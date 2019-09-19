import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:redux/redux.dart';

import 'package:nui/models/app_state.dart';

class ListsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ListsPageProps>(
      distinct: true,
      converter: (store) => mapStateToProps(store),
      builder: (context, props) {
        return Center(
          child: Text(props.accessToken),
        );
      }
    );
  }
}

class ListsPageProps {
  final String accessToken;

  ListsPageProps({
    this.accessToken,
  });
}

ListsPageProps mapStateToProps(Store<AppState> store) {
  return ListsPageProps(
    accessToken: store.state.authn.accessToken,
  );
}
