import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'const/import_const.dart';
import 'lang/lang_controller.dart';
import '/lang/translation_service.dart';
import 'routes/routes.dart';
import 'services/firebase/firebase_service.dart';
import 'utils/root_widget.dart';
import 'utils/web_utils/web_utils.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final lang = Get.find<LangController>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          onInit: WebUtils.removeLoader,
          debugShowCheckedModeBanner: false,
          enableLog: false,
          title: AppConfigs.appName,
          color: Colors.blue,
          defaultTransition: Transition.fadeIn,
          navigatorObservers: [...FirebaseService.analytics.getObservers()],
          theme: Styles.light,
          darkTheme: Styles.light,
          getPages: AppPages.routes,
          initialRoute: AppPages.initial,
          builder: RootWidget.builder,
          locale: lang.locale,
          fallbackLocale: TranslationService.fallbackLocale,
          translations: TranslationService(),
        );
      },
    );
  }
}
