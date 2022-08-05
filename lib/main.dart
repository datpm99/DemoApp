import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'services/services.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  await AppServices.init();

  if (!kIsWeb) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
  runApp(MyApp());

  // runZonedGuarded(() async {
  //   await Firebase.initializeApp();
  //   await AppServices.init();
  //
  //   if (!kIsWeb) {
  //     await SystemChrome.setPreferredOrientations([
  //       DeviceOrientation.portraitUp,
  //     ]);
  //   }
  //   runApp(MyApp());
  // }, (error, stackTrace) {
  //   debugPrint(
  //       'Caught error in app, use `FirebaseCrashlytics` to track it down.');
  //   debugPrint(error.toString());
  // });
}
