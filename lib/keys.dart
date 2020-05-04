import 'package:flutter/widgets.dart';

class AppKeys {
  // Navigator
  static final navigator = GlobalKey<NavigatorState>();

  // Loading Screen
  static final loadingScreen = const Key('__loadingScreen__');
  static final animatedLogo = const Key('__animatedLogo__');

  // Enrollment Screen
  static final enrollmentScreen = const Key('__enrollmentScreen__');
  static final enrollmentLoginPage = const Key('__enrollmentLoginPage__');
  static final enrollmentHomePage = const Key('__enrollmentHomePage__');
  static final enrollmentSignUpPage = const Key('__enrollmentSignUpPage__');

  // Main Screen
  static final mainScreen = const Key('__mainScreen__');
}
