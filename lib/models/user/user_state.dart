import 'package:nui/models/user/user.dart';

class UserState {
  GetUserInfoState getInfo;

  UserState({
    this.getInfo,
  });

  factory UserState.initial() => UserState(
    getInfo: GetUserInfoState.initial(),
  );
}

class GetUserInfoState {
  Error error;
  bool loading;
  User data;

  GetUserInfoState({
    this.error,
    this.loading,
    this.data,
  });

  factory GetUserInfoState.initial() => GetUserInfoState(
    error: null,
    loading: false,
    data: null,
  );
}
