import 'package:meta/meta.dart';

import 'package:nui/models/user/user_state.dart';
import 'package:nui/models/authn/authn_state.dart';

@immutable
class AppState {
  final AuthNState authn;
  final UserState user;

  AppState({
    this.authn,
    this.user,
  });

  factory AppState.initial() => AppState(
    authn: AuthNState.initial(),
    user: UserState.initial(),
  );

  AppState copyWith({
    AuthNState authn,
    UserState user,
  }) {
    return AppState(
      authn: authn ?? this.authn,
      user: user ?? this.user,
    );
  }
}
