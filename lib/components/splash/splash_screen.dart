import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:nui/routes.dart';

class SplashScreen extends StatefulWidget {
  final void Function(String email, String password) onInit;

  SplashScreen({@required this.onInit});

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    
    this.readToken().then((token) {
      if (token == null || token.isEmpty) {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      } else {
        widget.onInit("test", "test");
      }
    });
  }

  Future<String> readToken() async {
    return await storage.read(
      key: 'token',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/splash.png'),
            fit: BoxFit.cover
        ) ,
      ),
    );
  }
}
