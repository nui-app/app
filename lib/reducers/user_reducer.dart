import 'dart:convert';

import 'package:redux_api_middleware/redux_api_middleware.dart';

import 'package:nui/models/user/user.dart';
import 'package:nui/models/user/user_state.dart';

import 'package:nui/actions/user_actions.dart';

UserState userReducer(UserState state, dynamic action) {
  UserState newState = state;

  String type = action is FSA ? action.type : action['type'];
  print(type);

  switch (type) {
    case GET_USER_INFO_REQUEST:
      newState.getInfo.error = null;
      newState.getInfo.loading = true;
      newState.getInfo.data = null;
      return newState;

    case GET_USER_INFO_SUCCESS:
      newState.getInfo.error = null;
      newState.getInfo.loading = false;
      newState.getInfo.data = userFromJSONStr(action.payload);
      return newState;

    case GET_USER_INFO_FAILURE:
      newState.getInfo.error = action.payload;
      newState.getInfo.loading = false;
      newState.getInfo.data = null;
      return newState;

    default:
      return newState;
  }
}

User userFromJSONStr(dynamic payload) {
  return User.fromJSON(json.decode(payload));
}
