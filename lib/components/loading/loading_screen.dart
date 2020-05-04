import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:redux/redux.dart';

import 'package:nui/keys.dart';
import 'package:nui/routes.dart';

import 'package:nui/models/app_state.dart';
import 'package:nui/models/authn/authn.dart';
import 'package:nui/models/user/user_state.dart';

import 'package:nui/actions/user_actions.dart';
import 'package:nui/actions/authn_actions.dart';

import 'package:nui/components/loading/animated_logo.dart';
import 'package:redux_api_middleware/redux_api_middleware.dart';

class LoadingScreen extends StatefulWidget {
  final storage = FlutterSecureStorage();

  LoadingScreen() : super(key: AppKeys.mainScreen);

  @override
  State<StatefulWidget> createState() {
    return LoadingScreenState();
  }
}

class LoadingScreenState extends State<LoadingScreen> with SingleTickerProviderStateMixin {
  String accessToken = '';

  void handleInitialBuild(LoadingScreenViewModel vm) {
    widget.storage.read(
      key: 'access_data',
    ).then((data) {
      if (data == null) {
        Future.delayed(Duration(seconds: 2), () => AppKeys.navigator.currentState.pushReplacementNamed(AppRoutes.enrollment));
      } else {
        AuthN authN = AuthN.fromJSON(json.decode(data));
        setState(() => accessToken = authN.token);
        vm.getUserInfo(authN.token);
      }
    });
  }

  void handleDidChange(LoadingScreenViewModel newProps) {
    if (newProps.getUserInfoResponse.loading) {
      return;
    }

    Error error = newProps.getUserInfoResponse.error;
    if (error != null) {
      if (error is APIError) {
        if (error.status == 401) {
          AppKeys.navigator.currentState.pushReplacementNamed(AppRoutes.enrollment);
        }
      } else {
        // TODO Should show an error in screen
      }

      return;
    }

    if (newProps.getUserInfoResponse.data != null) {
      if (newProps.accessToken == null) {
        newProps.setAccessToken(accessToken);
      } else {
        AppKeys.navigator.currentState.pushReplacementNamed(AppRoutes.main);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoadingScreenViewModel>(
      distinct: true,
      converter: (store) => mapStateToViewModel(store),
      onInitialBuild: (vm) => this.handleInitialBuild(vm),
      onDidChange: (vm) => this.handleDidChange(vm),
      builder: (context, vm) {
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          AnimatedLogo(),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                        ),
                        Text(
                          'Loading...',
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class LoadingScreenViewModel {
  final String accessToken;
  final Function getUserInfo;
  final Function setAccessToken;
  final GetUserInfoState getUserInfoResponse;

  LoadingScreenViewModel({
    this.accessToken,
    this.getUserInfo,
    this.setAccessToken,
    this.getUserInfoResponse,
  });
}

LoadingScreenViewModel mapStateToViewModel(Store<AppState> store) {
  return LoadingScreenViewModel(
    accessToken: store.state.authn.accessToken,
    getUserInfoResponse: store.state.user.getInfo,
    getUserInfo: (String token) => store.dispatch(getUserInfo(token)),
    setAccessToken: (String token) => store.dispatch(setAccessToken(token)),
  );
}
