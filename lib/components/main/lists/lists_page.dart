import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:redux/redux.dart';

import 'package:nui/models/app_state.dart';

class ListsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ListsPageViewModel>(
      distinct: true,
      converter: (store) => mapStateToViewModel(store),
      builder: (context, vm) {
        return Center(
          child: Text(vm.accessToken),
        );
      }
    );
  }
}

class ListsPageViewModel {
  final String accessToken;

  ListsPageViewModel({
    this.accessToken,
  });
}

ListsPageViewModel mapStateToViewModel(Store<AppState> store) {
  return ListsPageViewModel(
    accessToken: store.state.authn.accessToken,
  );
}
