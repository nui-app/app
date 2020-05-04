import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:nui/keys.dart';

import 'package:nui/components/enrollment/home_page.dart';
import 'package:nui/components/enrollment/login_page.dart';
import 'package:nui/components/enrollment/signup_page.dart';

class EnrollmentScreen extends StatefulWidget {
  final storage = FlutterSecureStorage();

  EnrollmentScreen() : super(key: AppKeys.enrollmentScreen);

  @override
  EnrollmentScreenState createState() {
    return EnrollmentScreenState();
  }
}

class EnrollmentScreenState extends State<EnrollmentScreen> {
  PageController controller = PageController(initialPage: 1, viewportFraction: 1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: this.controller,
        scrollDirection: Axis.horizontal,
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          SignUpPage(),
          HomePage(
            onLoginPagePressed: () => this.goToPage(2),
            onSignUpPagePressed: () => this.goToPage(0),
          ),
          LoginPage(),
        ],
      ),
    );
  }

  void goToPage(int pos) {
    this.controller.animateToPage(
      pos,
      curve: Curves.easeIn,
      duration: Duration(milliseconds: 500),
    );
  }
}
