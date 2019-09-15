import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nui/components/base/base_screen.dart';

import 'package:redux/redux.dart';

import 'package:nui/keys.dart';
import 'package:nui/routes.dart';

import 'package:nui/models/app_state.dart';
import 'package:nui/models/authn/authn.dart';
import 'package:nui/models/authn/authn_state.dart';

import 'package:nui/actions/authn_actions.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen() : super(key: AppKeys.loginScreen);

  @override
  LoginScreenState createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";

  final storage = FlutterSecureStorage();

  final TextEditingController emailFilter = TextEditingController();
  final TextEditingController passwordFilter = TextEditingController();

  LoginScreenState() {
    this.emailFilter.addListener(this.emailListener);
    this.passwordFilter.addListener(this.passwordListener);
  }

  void handleDidChange(LoginScreenProps newProps) async {
    AuthN data = newProps.authenticateResponse.data;
    if (data != null) {
      await this.storage.write(
        key: 'access_data',
        value: json.encode(data.toJSON()),
      );

      Navigator.pushReplacementNamed(this.context, AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoginScreenProps>(
      distinct: true,
      converter: (store) => mapStateToProps(store),
      onDidChange: (newProps) => this.handleDidChange(newProps),
      builder: (context, props) {
        return BaseScreen(
          title: 'Login',
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    children: this.buildTextFields(),
                  ),
                ),
                RaisedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    props.authenticate(this.email, this.password);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> buildTextFields() {
    return [
      Container(
        child: TextField(
          controller: this.emailFilter,
          decoration: InputDecoration(
            labelText: 'E-mail',
          ),
        ),
      ),
      Container(
        child: TextField(
          obscureText: true,
          controller: this.passwordFilter,
          decoration: InputDecoration(
            labelText: 'Password'
          ),
        ),
      ),
    ];
  }

  void emailListener() {
    if (this.emailFilter.text.isEmpty) {
      this.email = '';
    } else {
      this.email = this.emailFilter.text;
    }
  }

  void passwordListener() {
    if (this.passwordFilter.text.isEmpty) {
      this.password = "";
    } else {
      this.password = passwordFilter.text;
    }
  }
}

class LoginScreenProps {
  final Function authenticate;
  final AuthenticateState authenticateResponse;

  LoginScreenProps({
    this.authenticate,
    this.authenticateResponse,
  });
}

LoginScreenProps mapStateToProps(Store<AppState> store) {
  return LoginScreenProps(
    authenticateResponse: store.state.authn.authenticate,
    authenticate: (String email, String password) => store.dispatch(authenticate(email, password)),
  );
}
