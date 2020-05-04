import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_api_middleware/redux_api_middleware.dart';

import 'package:nui/keys.dart';
import 'package:nui/routes.dart';

import 'package:nui/models/app_state.dart';

import 'package:nui/reducers/app_reducer.dart';

import 'package:nui/components/main/main_screen.dart';
import 'package:nui/components/enrollment/enrollment_screen.dart';
import 'package:nui/components/loading/loading_screen.dart';

void main() {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [thunkMiddleware, apiMiddleware],
  );

  runApp(App(
    store: store,
  ));
}

class App extends StatelessWidget {
  final Store<AppState> store;

  App({ this.store });

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: this.store,
      child: MaterialApp(
        title: 'Nui',
        navigatorKey: AppKeys.navigator,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        routes: {
          AppRoutes.loading: (context) => LoadingScreen(),
          AppRoutes.enrollment: (context) => EnrollmentScreen(),
          AppRoutes.main: (context) => MainScreen(),
        },
      ),
    );
  }
}
