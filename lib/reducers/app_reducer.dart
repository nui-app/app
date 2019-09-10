import 'package:nui/models/app_state.dart';
import 'package:nui/reducers/authn_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    authn: authNReducer(state.authn, action),
  );
}
