import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_api_middleware/redux_api_middleware.dart';

import 'package:nui/routes.dart';

import 'package:nui/models/app_state.dart';

import 'package:nui/actions/authn_actions.dart';

import 'package:nui/reducers/app_reducer.dart';

import 'package:nui/components/splash/splash_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [thunkMiddleware, apiMiddleware],
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: this.store,
      child: MaterialApp(
        title: 'Nui',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          AppRoutes.splash: (context) => SplashScreen(
            onInit: (String email, String password) => this.store.dispatch(authenticate(email, password)),
          ),
        },
      ),
    );
  }
}
