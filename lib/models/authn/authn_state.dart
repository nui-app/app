import 'package:nui/models/authn/authn.dart';

class AuthNState {
  String accessToken;
  AuthenticateState authenticate;

  AuthNState({
    this.accessToken,
    this.authenticate,
  });

  factory AuthNState.initial() => AuthNState(
    accessToken: null,
    authenticate: AuthenticateState.initial(),
  );
}

class AuthenticateState {
  Error error;
  bool loading;
  AuthN data;

  AuthenticateState({
    this.error,
    this.loading,
    this.data,
  });

  factory AuthenticateState.initial() => AuthenticateState(
    error: null,
    loading: false,
    data: null,
  );
}
