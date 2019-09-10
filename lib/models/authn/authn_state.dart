import 'package:nui/models/authn/authn.dart';

class AuthNState {
  AuthenticateState authenticate;

  AuthNState({
    this.authenticate,
  });

  factory AuthNState.initial() => AuthNState(
    authenticate: AuthenticateState.initial(),
  );
}

class AuthenticateState {
  dynamic error;
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
