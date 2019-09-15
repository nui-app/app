import 'dart:convert';

import 'package:redux_api_middleware/redux_api_middleware.dart';

import 'package:nui/models/authn/authn.dart';
import 'package:nui/models/authn/authn_state.dart';

import 'package:nui/actions/authn_actions.dart';

AuthNState authNReducer(AuthNState state, FSA action) {
  AuthNState newState = state;

  switch (action.type) {
    case AUTHENTICATE_REQUEST:
      newState.authenticate.error = null;
      newState.authenticate.loading = true;
      newState.authenticate.data = null;
      return newState;

    case AUTHENTICATE_SUCCESS:
      newState.authenticate.error = null;
      newState.authenticate.loading = false;
      newState.authenticate.data = authNFromJSONStr(action.payload);
      return newState;

    case AUTHENTICATE_FAILURE:
      newState.authenticate.error = action.payload;
      newState.authenticate.loading = false;
      newState.authenticate.data = null;
      return newState;

    default:
      return newState;
  }
}

AuthN authNFromJSONStr(dynamic payload) {
  return AuthN.fromJSON(json.decode(payload));
}
