import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app_root.dart';
import 'app/app_state.dart';
import 'app/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appState = AppState();
  await appState.init();

  runApp(
    ChangeNotifierProvider.value(
      value: appState,
      child: AppRoot(router: buildRouter(appState)),
    ),
  );
}
