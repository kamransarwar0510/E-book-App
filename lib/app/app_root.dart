import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'theme.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key, required this.router});
  final RouterConfig<Object> router;

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        final seed = const Color(0xFF7C4DFF);

        final lightScheme = (app.useDynamicColor ? lightDynamic : null) ??
            ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light);

        final darkScheme = (app.useDynamicColor ? darkDynamic : null) ??
            ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark);

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          themeMode: app.materialThemeMode,
          theme: buildLightTheme(lightScheme),
          darkTheme: buildDarkTheme(darkScheme),
          routerConfig: router,
        );
      },
    );
  }
}
