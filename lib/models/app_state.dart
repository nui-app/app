import 'package:meta/meta.dart';

import 'package:nui/models/authn/authn_state.dart';

@immutable
class AppState {
  final AuthNState authn;

  AppState({
    this.authn,
  });

  factory AppState.initial() => AppState(
    authn: AuthNState.initial(),
  );

  AppState copyWith({
    AuthNState authn,
  }) {
    return AppState(
      authn: authn ?? this.authn,
    );
  }
}
