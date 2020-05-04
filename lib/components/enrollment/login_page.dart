import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_progress_button/reveal_progress_button.dart';

import 'package:redux/redux.dart';
import 'package:redux_api_middleware/redux_api_middleware.dart';

import 'package:nui/keys.dart';
import 'package:nui/routes.dart';

import 'package:nui/models/app_state.dart';
import 'package:nui/models/authn/authn.dart';
import 'package:nui/models/authn/authn_state.dart';

import 'package:nui/actions/authn_actions.dart';

const emailKey = 'email';
const passwordKey = 'password';
const cPasswordKey = 'cpassword';

class LoginPage extends StatefulWidget {
  final storage = FlutterSecureStorage();

  LoginPage() : super(key: AppKeys.enrollmentLoginPage);

  @override
  LoginPageState createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoginPageViewModel>(
      distinct: true,
      converter: (store) => mapStateToViewModel(store),
      builder: (context, vm) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            this.buildLogo(),
            this.buildForm(vm),
            this.buildSubmitButton(vm),
          ],
        );
      }
    );
  }

  Widget buildLogo() {
    return Container(
      margin: const EdgeInsets.only(bottom: 50.0),
      child: Image(
        width: 50.0,
        height: 50.0,
        image: AssetImage('assets/logo.png'),
      ),
    );
  }

  Widget buildForm(LoginPageViewModel vm) {
    return Form(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            this.buildFormField(
              key: emailKey,
              label: 'E-mail',
              focusNode: this.emailFocus,
              action: TextInputAction.next,
              hint: 'fulana@exemplo.com.br',
              controller: this.emailController,
              onSubmitted: (_) {
                this.handleFocusChange(context, passwordFocus);
              },
            ),
            this.buildFormField(
              key: passwordKey,
              obscureText: true,
              label: 'Senha',
              action: TextInputAction.next,
              focusNode: this.passwordFocus,
              controller: this.passwordController,
              onSubmitted: (_) {
                this.handleSubmit(vm);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFormField({
    String key,
    String hint,
    String label,
    String error,
    Function onTap,
    bool obscureText = false,
    FocusNode focusNode,
    Function onSubmitted,
    TextInputAction action = TextInputAction.go,
    TextEditingController controller,
  }) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
      child: TextFormField(
        onTap: onTap,
        focusNode: focusNode,
        controller: controller,
        textInputAction: action,
        obscureText: obscureText,
        textAlign: TextAlign.left,
        onFieldSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget buildSubmitButton(LoginPageViewModel vm) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
      child: RevealProgressButton(
        label: 'LOGIN',
        bgColor: Colors.greenAccent,
        revealColor: Colors.greenAccent,
        loading: vm.authenticateResponse.loading,
        done: vm.authenticateResponse.data != null,
        error: vm.authenticateResponse.error != null,
        onPressed: () {
          this.handleSubmit(vm);
        },
        onError: () {
          this.handleError(vm);
        },
        onSuccess: () {
          this.handleSuccess(vm);
        },
      ),
    );
  }

  void handleSubmit(LoginPageViewModel vm) {
    FocusScope.of(context).requestFocus(FocusNode());
    vm.authenticate(this.emailController.value.text, this.passwordController.value.text);
  }

  void handleError(LoginPageViewModel vm) {
    Error error = vm.authenticateResponse.error;
    if (error is APIError) {
      if (error.status == 401) {
        // TODO Should show an error in screen
      }
    } else {
      // TODO Should show an error in screen
    }
  }

  void handleSuccess(LoginPageViewModel vm) async {
    AuthN data = vm.authenticateResponse.data;
    if (data != null) {
      await widget.storage.write(
        key: 'access_data',
        value: json.encode(data.toJSON()),
      );

      vm.setAccessToken(data.token);
      AppKeys.navigator.currentState.pushReplacementNamed(AppRoutes.main);
    }
  }

  void handleFocusChange(BuildContext context, FocusNode nextFocus) {
    emailFocus.unfocus();
    passwordFocus.unfocus();

    FocusScope.of(context).requestFocus(nextFocus);
  }
}

class LoginPageViewModel {
  final String accessToken;
  final Function authenticate;
  final Function setAccessToken;
  final AuthenticateState authenticateResponse;

  LoginPageViewModel({
    this.accessToken,
    this.authenticate,
    this.setAccessToken,
    this.authenticateResponse,
  });
}

LoginPageViewModel mapStateToViewModel(Store<AppState> store) {
  return LoginPageViewModel(
    accessToken: store.state.authn.accessToken,
    authenticateResponse: store.state.authn.authenticate,
    setAccessToken: (String token) => store.dispatch(setAccessToken(token)),
    authenticate: (String email, String password) => store.dispatch(authenticate(email, password)),
  );
}
