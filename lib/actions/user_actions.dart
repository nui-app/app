import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_api_middleware/redux_api_middleware.dart';

import 'package:nui/models/app_state.dart';

const GET_USER_INFO_REQUEST = 'GET_USER_INFO_REQUEST';
const GET_USER_INFO_SUCCESS = 'GET_USER_INFO_SUCCESS';
const GET_USER_INFO_FAILURE = 'GET_USER_INFO_FAILURE';

RSAA getUserInfoRequest(String token) {
  return
    RSAA(
      method: 'GET',
      endpoint: 'http://10.0.2.2:8080/api/user/info',
      types: [
        GET_USER_INFO_REQUEST,
        GET_USER_INFO_SUCCESS,
        GET_USER_INFO_FAILURE,
      ],
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
}

ThunkAction<AppState> getUserInfo(String token) => (Store<AppState> store) => store.dispatch(getUserInfoRequest(token));
