import 'package:flutter/material.dart';

import 'package:nui/keys.dart';

const emailKey = 'email';
const passwordKey = 'password';
const cPasswordKey = 'cpassword';

class SignUpPage extends StatefulWidget {
  SignUpPage() : super(key: AppKeys.enrollmentSignUpPage);

  @override
  SignUpPageState createState() {
    return SignUpPageState();
  }
}

class SignUpPageState extends State<SignUpPage> {
  Map<String, String> errors = {};

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final emailFocus = FocusNode();  
  final passwordFocus = FocusNode();  
  final confirmPasswordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: this.buildLogo(),
            ),
            Expanded(
              flex: 1,
              child: Form(
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
                        onSubmitted: this.validateEmail,
                      ),
                      this.buildFormField(
                        key: passwordKey,
                        obscureText: true,
                        label: 'Senha',
                        action: TextInputAction.next,
                        focusNode: this.passwordFocus,
                        controller: this.passwordController,
                        onSubmitted: this.validatePassword,
                      ),
                      this.buildFormField(
                        key: cPasswordKey,
                        obscureText: true,
                        label: 'Confirmar senha',
                        focusNode: this.confirmPasswordFocus,
                        controller: this.confirmPasswordController,
                        onSubmitted: this.validateCPassword,
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
                        child: this.buildSubmitButton(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildLogo() {
    return Container(
      margin: const EdgeInsets.only(top: 50.0),
      child: Image(
        width: 50.0,
        height: 50.0,
        image: AssetImage('assets/logo.png'),
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
        onChanged: (term) {
          var newErrors = errors;
          newErrors[key] = null;

          this.setState(() {
            errors = newErrors;
          });
        },
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          errorText: errors[key],
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget buildSubmitButton() {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Colors.greenAccent,
      onPressed: () => print(''),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 15.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Text(
                "ENVIAR",
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

  bool isEmailValid(String email) {
    return RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(email);
  }

  bool isPasswordValid(String password) {
    return password != null && password.length >= 6;
  }

  bool isCPasswordValid(String cPassword) {
    return cPassword == this.passwordController.value.text;
  }

  void validateEmail(String email) {
    if (this.isEmailValid(email)) {
      this.handleFocusChange(context, this.passwordFocus);
    } else {
      var newErrors = errors;
      newErrors[emailKey] = 'Type a valid e-mail';

      this.setState(() {
        errors = newErrors;
      });
    }
  }

  void validatePassword(String password) {
    if (!this.isEmailValid(this.emailController.value.text)) {
      this.handleFocusChange(context, this.emailFocus);
      return;
    }

    if (this.isPasswordValid(password)) {
      this.handleFocusChange(context, this.confirmPasswordFocus);
    } else {
      var newErrors = errors;
      newErrors[passwordKey] = 'Should have at least 6 characters';

      this.setState(() {
        errors = newErrors;
      });
    }
  }

  void validateCPassword(String cPassword) {
    if (!this.isEmailValid(this.emailController.value.text)) {
      this.handleFocusChange(context, this.emailFocus);
      return;
    }

    if (!this.isPasswordValid(this.passwordController.value.text)) {
      this.handleFocusChange(context, this.passwordFocus);
      return;
    }

    if (this.isCPasswordValid(cPassword)) {
      // TODO Submit
    } else {
      var newErrors = errors;
      newErrors[cPasswordKey] = 'Passwords are different';

      this.setState(() {
        errors = newErrors;
      });
    }
  }

  void handleFocusChange(BuildContext context, FocusNode nextFocus) {
    emailFocus.unfocus();
    passwordFocus.unfocus();
    confirmPasswordFocus.unfocus();

    FocusScope.of(context).requestFocus(nextFocus);
  }

  void handleSubmit() {
    if (!this.isEmailValid(this.emailController.value.text)) {
      this.handleFocusChange(context, this.emailFocus);
      return;
    }

    if (!this.isPasswordValid(this.passwordController.value.text)) {
      this.handleFocusChange(context, this.passwordFocus);
      return;
    }

    if (!this.isCPasswordValid(this.confirmPasswordController.value.text)) {
      this.handleFocusChange(context, this.confirmPasswordFocus);
      return;
    }

    // TODO Submit
  }
}
