import 'package:DriveVue/splash_screen.dart';
import 'package:DriveVue/terms_and_conditions.dart';
import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../screens/camera_tips.dart';
import '../screens/main_screen.dart';
import '../screens/object_recognition_main.dart';
import '../screens/on_boarding_pg_one.dart';
import '../screens/on_boarding_pg_two.dart';
import '../screens/on_boarding_pg_three.dart';
import '../screens/splash_screen.dart';
import '../screens/terms_and_conditions.dart';
import '../screens/tutorial_end.dart';
import '../screens/tutorial_main.dart';
import '../screens/tutorial_object_recognition_main.dart';
import '../screens/welcome.dart';

class AppRoutes {
  static const String splashscreenScreen = '/splash_screen';
  static const String onBoardingPgOneScreen = '/on_boarding_pg_one';
  static const String onBoardingPgTwoScreen = '/on_boarding_pg_two';
  static const String onBoardingPgThreeScreen = '/on_boarding_pg_three';
  static const String tncScreen = '/terms_and_conditions';
  static const String welcomeScreen = '/welcome';
  static const String tutorialMainPageScreen = '/tutorial_main';
  static const String tutorialObjectRecognitionMainPageScreen =
      '/tutorial_object_recognition_main';
  static const String tutorialEndScreen = '/tutorial_end';
  static const String mainPageScreen = '/main_screen';
  static const String tipsOnPlacingCameraScreen = '/camera_tips';
  static const String objectRecognitionMainPageScreen =
      '/object_recognition_main';
  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    splashscreenScreen: (context) => SplashScreen(),
    onBoardingPgOneScreen: (context) => OnBoardingPgOneScreen(),
    onBoardingPgTwoScreen: (context) => OnBoardingPgTwoScreen(),
    onBoardingPgThreeScreen: (context) => OnBoardingPgThreeScreen(),
    tncScreen: (context) => TermsAndConditions(),
    welcomeScreen: (context) => WelcomeScreen(),
    tutorialMainPageScreen: (context) => TutorialMainPageScreen(),
    tutorialObjectRecognitionMainPageScreen: (context) =>
        TutorialObjectRecognitionMainPageScreen(),
    tutorialEndScreen: (context) => TutorialEndScreen(),
    mainPageScreen: (context) => MainScreen(),
    tipsOnPlacingCameraScreen: (context) => CameraTipsScreen(),
    objectRecognitionMainPageScreen: (context) =>
        ObjectRecognitionMainPageScreen(),
    initialRoute: (context) => SplashScreen()
  };
}
