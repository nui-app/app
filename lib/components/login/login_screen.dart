import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:redux_api_middleware/redux_api_middleware.dart';

import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:nui/keys.dart';
import 'package:nui/routes.dart';

import 'package:nui/models/app_state.dart';
import 'package:nui/models/authn/authn.dart';
import 'package:nui/models/authn/authn_state.dart';

import 'package:nui/actions/authn_actions.dart';

class LoginScreen extends StatefulWidget {
  final storage = FlutterSecureStorage();

  LoginScreen() : super(key: AppKeys.loginScreen);

  @override
  LoginScreenState createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';

  final TextEditingController emailFilter = TextEditingController();
  final TextEditingController passwordFilter = TextEditingController();

  LoginScreenState() {
    this.emailFilter.addListener(this.emailListener);
    this.passwordFilter.addListener(this.passwordListener);
  }

  void handleDidChange(LoginScreenProps newProps) async {
    if (newProps.authenticateResponse.loading) {
      return;
    }

    Error error = newProps.authenticateResponse.error;
    if (error != null) {
      if (error is APIError) {
        if (error.status == 401) {
          AppKeys.navigator.currentState.pushReplacementNamed(AppRoutes.login);
        }
      } else {
        // TODO Should show an error in screen
      }

      return;
    }

    if (newProps.accessToken == null) {
      AuthN data = newProps.authenticateResponse.data;
      if (data != null) {
        await widget.storage.write(
          key: 'access_data',
          value: json.encode(data.toJSON()),
        );

        newProps.setAccessToken(data.token);
      }
    } else {
      AppKeys.navigator.currentState.pushReplacementNamed(AppRoutes.main);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoginScreenProps>(
      distinct: true,
      converter: (store) => mapStateToProps(store),
      onDidChange: (newProps) => this.handleDidChange(newProps),
      builder: (context, props) {
        return Stack(
          children: <Widget>[
            Container(
              color: Colors.green,
              child: Image.asset('assets/pattern.jpg'),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: this.buildAppBar(),
              body: this.buildContent(props.authenticate),
            ),
          ],
        );
      },
    );
  }

  Widget buildAppBar() {
    return AppBar(
      elevation: 0.0,
      title: Text('Login'),
      backgroundColor: Colors.transparent,
    );
  }

  Widget buildContent(Function authenticate) {
    return Container(
      color: Colors.white,
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
                authenticate(this.email, this.password);
              },
            ),
          ],
        ),
      ),
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
  final String accessToken;
  final Function authenticate;
  final Function setAccessToken;
  final AuthenticateState authenticateResponse;

  LoginScreenProps({
    this.accessToken,
    this.authenticate,
    this.setAccessToken,
    this.authenticateResponse,
  });
}

LoginScreenProps mapStateToProps(Store<AppState> store) {
  return LoginScreenProps(
    accessToken: store.state.authn.accessToken,
    authenticateResponse: store.state.authn.authenticate,
    setAccessToken: (String token) => store.dispatch(setAccessToken(token)),
    authenticate: (String email, String password) => store.dispatch(authenticate(email, password)),
  );
}
