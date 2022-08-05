import 'dart:math';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '/services/storage/storage_service.dart';
import '/utils/web_utils/web_utils.dart';
import '/utils/app_logger.dart';
import '/services/services.dart';
import '/routes/routes.dart';
import 'analytics.dart';

class FirebaseService extends GetxService implements BaseService {
  static FirebaseService get() => Get.find();
  final _log = AppLog('FirebaseService');

  static final analytics = AppAnalytics();

  late bool _fcmEnabled;
  bool _crashlyticsEnabled = false;
  late String _fcmToken;

  bool get crashlyticsEnabled => _crashlyticsEnabled;

  bool get fcmEnabled => _fcmEnabled;

  bool get analyticsEnabled => analytics.enabled;

  String get fcmToken => _fcmToken;
  final _fcm = FirebaseMessaging.instance;

  @override
  Future<void> init() async {
    _initCapabilities();
    _initCrashlytics();
  }

  void _initCapabilities() {
    analytics.init();
    if (GetPlatform.isMobile) {
      _fcmEnabled = true;
    } else {
      _crashlyticsEnabled =
          !GetPlatform.isWeb && !WebUtils.isSimulator && !kDebugMode;
      _fcmEnabled =
          !GetPlatform.isWeb && !GetPlatform.isDesktop && !WebUtils.isSimulator;
    }
    _log('Firebase analytics enabled: $analyticsEnabled');
    _log('Firebase crashlytics enabled: $_crashlyticsEnabled');
    _log('Firebase FCM enabled: $_fcmEnabled');
  }

  Future<void> _initCrashlytics() async {
    if (!crashlyticsEnabled) return;
    // Pass all uncaught errors to Crashlytics.
    Function originalOnError = FlutterError.onError!;
    FlutterError.onError = (errorDetails) async {
      // await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      // Forward to original handler.
      originalOnError(errorDetails);
    };
    if (kDebugMode) {
      // Force disable Crashlytics collection while doing every day development.
      // Temporarily toggle this to true if you want to test crash reporting in your app.
      //       crashlytics.sendUnsentReports();
    } else {
      // Handle Crashlytics enabled status when not in Debug,
      // e.g. allow your users to opt-in to crash reporting.
    }
  }

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  Random random = Random();

  Future createLocalNotify(String title, String body) async {
    await flutterLocalNotificationsPlugin.show(
      random.nextInt(10000),
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        ),
      ),
    );
  }

  /// --- notifications ---
  Future<void> initFCM() async {
    if (!fcmEnabled) return;
    await getTokenFirebase();

    //Init Local notification.
    const AndroidInitializationSettings initSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initSettings = InitializationSettings(
      android: initSettingsAndroid,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    if (GetPlatform.isAndroid) {
      await flutterLocalNotificationsPlugin.initialize(initSettings);
    }

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    NotificationSettings settings = await _fcm.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      //Foreground State. - App running.
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        debugPrint("onMessage: ${message.notification}");
        debugPrint('Message data: ${message.data}');
        //TODO: (Not have notification) Create local notification.
        if (message.notification != null) {
          if (GetPlatform.isAndroid) {
            await createLocalNotify(
                message.notification!.title!, message.notification!.body!);
          }
        }
      });

      //Background State. - App run background(hide on screen).
      FirebaseMessaging.onMessageOpenedApp
          .listen((RemoteMessage message) async {
        if (message.notification != null) {
          //TODO something.
          debugPrint("onMessageOpenedApp: ${message.notification}");
          debugPrint('Message data: ${message.data}');
        }
      });

      //Terminated State.
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    debugPrint("REMOTE MESSAGE $message");
    await Firebase.initializeApp();
    //TODO something.
  }

  Future<void> getTokenFirebase() async {
    _fcmToken = (await FirebaseMessaging.instance.getToken())!;
    debugPrint("FCM_TOKEN: $_fcmToken");
  }

  /// --- DynamicLink ---
  ///https://vpswebdev.bssd.vn/app/contract/3419/sign?idDoc=3419&loginType=EXTERNAL
  Future<void> initDynamicLink() async {
    //Terminated State.
    final initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
    final _storage = Get.find<StorageService>();
    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
      debugPrint('DynamicLink: $deepLink');
      _storage.companyCode = deepLink.host;

      final queryParams = deepLink.queryParameters;
      if (queryParams.isNotEmpty) {
        _storage.loginType = queryParams["loginType"] ?? 'INTERNAL';
      }
      return;
    }

    //Background / Foreground State.
    FirebaseDynamicLinks.instance.onLink.listen((event) {
      final Uri deepLink = event.link;
      debugPrint('DynamicLink: $deepLink');
      _storage.companyCode = deepLink.host;

      final queryParams = deepLink.queryParameters;
      if (queryParams.isNotEmpty) {
        _storage.loginType = queryParams["loginType"] ?? 'INTERNAL';
      }

      if (_storage.sessionTimeout.isNotEmpty) {
        if (_storage.loginType == 'EXTERNAL') {
          Get.offAllNamed(Routes.loginOutSide);
        } else {
          Get.offAllNamed(Routes.login);
        }
        return;
      } else {
        // Get.offAllNamed(RoutesEContract.root);
      }
    }).onError((error) {
      debugPrint('onLinkError: ${error.message}');
    });
  }
}
