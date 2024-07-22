import 'package:flutter/material.dart';

class ThemeModel {
  final ThemeMode themeMode;
  final ThemeData lightTheme;
  final ThemeData darkTheme;
  ThemeModel(
      {required this.themeMode,
      required this.lightTheme,
      required this.darkTheme});

  /// Toggles the theme mode between light, dark, and system.
  ThemeModel toggle() {
    return ThemeModel(
        themeMode: themeMode == ThemeMode.system
            ? ThemeMode.light
            : themeMode == ThemeMode.light
                ? ThemeMode.dark
                : ThemeMode.system,
        lightTheme: lightTheme,
        darkTheme: darkTheme);
  }

  ThemeModel copyWith(
      {ThemeMode? themeMode, ThemeData? lightTheme, ThemeData? darkTheme}) {
    return ThemeModel(
        themeMode: themeMode ?? this.themeMode,
        lightTheme: lightTheme ?? this.lightTheme,
        darkTheme: darkTheme ?? this.darkTheme);
  }
}
