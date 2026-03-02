import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildLightTheme(ColorScheme scheme) {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    brightness: Brightness.light,
    textTheme: GoogleFonts.interTextTheme(),
  );

  return base.copyWith(
    appBarTheme: const AppBarTheme(centerTitle: false),
    cardTheme: CardTheme(
      elevation: 0,
      color: scheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    searchBarTheme: SearchBarThemeData(
      elevation: const WidgetStatePropertyAll(0),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    ),
  );
}

ThemeData buildDarkTheme(ColorScheme scheme) {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    brightness: Brightness.dark,
    textTheme: GoogleFonts.interTextTheme(ThemeData(brightness: Brightness.dark).textTheme),
  );

  return base.copyWith(
    appBarTheme: const AppBarTheme(centerTitle: false),
    cardTheme: CardTheme(
      elevation: 0,
      color: scheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );
}
