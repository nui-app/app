import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:redux/redux.dart';

import 'package:nui/routes.dart';

import 'package:nui/models/app_state.dart';
import 'package:nui/models/authn/authn.dart';
import 'package:nui/models/authn/authn_state.dart';

import 'package:nui/actions/authn_actions.dart';

class LoginScreen extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoginScreenProps>(
      converter: (store) => mapStateToProps(store),
      builder: (context, props) {
        // AuthN data = props.authenticateResponse.data;
        // if (data != null) {
        //   print(data.token);
        //   Navigator.pushNamed(context, AppRoutes.splash);
        // }

        return Scaffold(
          appBar: AppBar(
            title: Text('Login'),
          ),
          body: Container(
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
