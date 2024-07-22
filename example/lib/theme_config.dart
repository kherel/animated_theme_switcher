import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light();

ThemeData darkTheme = ThemeData.dark();

class PinkTheme {
  static ThemeData light = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF49FB6)),
  );
  static ThemeData dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFF49FB6), brightness: Brightness.dark),
  );
}

class HalloweenTheme {
  static ThemeData light = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF55705A)),
  );
  static ThemeData dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF55705A), brightness: Brightness.dark),
  );
}

class BlueTheme {
  static ThemeData light = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E1E2C)));
  static ThemeData dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF1E1E2C), brightness: Brightness.dark),
  );
}

class YellowTheme {
  static ThemeData light = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE8D7B1)));
  static ThemeData dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFE8D7B1), brightness: Brightness.dark),
  );
}

enum ThemeType {
  flutterDefault,
  pink,
  halloween,
  blue,
  yellow;

  (ThemeData, ThemeData) get getThemeData {
    switch (this) {
      case ThemeType.pink:
        return (PinkTheme.light, PinkTheme.dark);
      case ThemeType.halloween:
        return (HalloweenTheme.light, HalloweenTheme.dark);
      case ThemeType.blue:
        return (BlueTheme.light, BlueTheme.dark);
      case ThemeType.yellow:
        return (YellowTheme.light, YellowTheme.dark);
      default:
        return (lightTheme, darkTheme);
    }
  }
}
