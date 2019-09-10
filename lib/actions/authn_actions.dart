import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_api_middleware/redux_api_middleware.dart';

import 'package:nui/models/app_state.dart';


const AUTHENTICATE_REQUEST = 'AUTHENTICATE_REQUEST';
const AUTHENTICATE_SUCCESS = 'AUTHENTICATE_SUCCESS';
const AUTHENTICATE_FAILURE = 'AUTHENTICATE_FAILURE';

RSAA authenticateRequest(String email, String password) {
  return
    RSAA(
      method: 'POST',
      endpoint: 'http://jsonplaceholder.typicode.com/users',
      types: [
        AUTHENTICATE_REQUEST,
        AUTHENTICATE_SUCCESS,
        AUTHENTICATE_FAILURE,
      ],
      headers: {
        'Content-Type': 'application/json',
      },
    );
}

ThunkAction<AppState> authenticate(String email, String password) => (Store<AppState> store) => store.dispatch(authenticateRequest(email, password));
