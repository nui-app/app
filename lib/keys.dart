import 'package:flutter/widgets.dart';

class AppKeys {
  // Navigator
  static final navigator = GlobalKey<NavigatorState>();

  // Loading Screen
  static final loadingScreen = const Key('__loadingScreen__');
  static final animatedLogo = const Key('__animatedLogo__');

  // Login Screen
  static final loginScreen = const Key('__loginScreen__');

  // Main Screen
  static final mainScreen = const Key('__mainScreen__');
}
