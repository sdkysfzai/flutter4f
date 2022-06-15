import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loginv1/controllers/controllers.dart';
import 'package:loginv1/controllers/language_controller.dart';
import 'package:loginv1/helpers/helpers.dart';
import 'package:loginv1/ui/pages/home_page.dart';
import 'package:loginv1/ui/reglog/splash_screen.dart';
import 'package:loginv1/ui/widgets/loading.dart';
import 'controllers/auth_controller.dart';
import 'db/db_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await DBHelper.initDb();
  Get.put<AuthController>(AuthController());

  Get.put<LanguageController>(LanguageController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(
      builder: (languageController) => Loading(
        child: GetMaterialApp(
          translations: Localization(),
          locale: languageController.getLocale, // <- Current locale
          navigatorObservers: [
            // FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
          ],
          debugShowCheckedModeBanner: false,
          //defaultTransition: Transition.fade,

          themeMode: ThemeMode.system,
          home: SplashScreen(),
        ),
      ),
    );
  }
}
