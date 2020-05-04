import 'package:flutter/material.dart';

import 'package:nui/keys.dart';

class HomePage extends StatelessWidget {
  final Function onLoginPagePressed;
  final Function onSignUpPagePressed;

  HomePage({
    this.onLoginPagePressed,
    this.onSignUpPagePressed,
  }) : super(key: AppKeys.enrollmentHomePage);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.greenAccent,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: this.buildLogo(),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 10.0, left: 30.0, right: 30.0),
                    child: this.buildSignUpButton(),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
                    child: this.buildLoginButton(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildLogo() {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 40.0,
      child: Image(
        width: 40.0,
        height: 40.0,
        image: AssetImage('assets/logo.png'),
      ),
    );
  }

  Widget buildSignUpButton() {
    return OutlineButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      borderSide: BorderSide(
        color: Colors.white,
      ),
      onPressed: this.onSignUpPagePressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Text(
                "CADASTRAR",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLoginButton() {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Colors.white,
      onPressed: this.onLoginPagePressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Text(
                "ENTRAR",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
