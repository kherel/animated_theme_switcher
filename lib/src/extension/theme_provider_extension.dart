import 'package:animated_theme_switcher/src/theme_notifier.dart';
import 'package:flutter/material.dart';

import '../theme_provider.dart';
import '../theme_switcher.dart';

extension ThemeProviderExtension on BuildContext {
  /// This should only be called if there's ThemeSwitcher widget in the widget tree.
  void Function(
      {bool animateTransition,
      ThemeData? darkTheme,
      bool isReversed,
      ThemeData? lightTheme,
      Offset? offset,
      void Function()? onAnimationFinish}) get updateTheme {
    return ThemeSwitcher.of(this).updateTheme;
  }

  /// This should only be called if there's ThemeSwitcher widget in the widget tree.
  void Function(
      {bool animateTransition,
      Offset? offset,
      void Function()? onAnimationFinish,
      bool isReversed}) get toggleThemeMode {
    return ThemeSwitcher.of(this).toggleThemeMode;
  }

  /// This should only be called if there's ThemeSwitcher widget in the widget tree.
  void Function(
      {bool animateTransition,
      Offset? offset,
      void Function()? onAnimationFinish,
      bool isReversed,
      required ThemeMode themeMode}) get updateThemeMode {
    return ThemeSwitcher.of(this).updateThemeMode;
  }

  ThemeNotifier get themeNotifier => ThemeModelInheritedNotifier.of(this);
  ThemeData get theme => themeNotifier.lightTheme;
  ThemeData get darkTheme => themeNotifier.darkTheme;
  ThemeMode get themeMode => themeNotifier.themeMode;
  Brightness get brightness => themeNotifier.themeMode == ThemeMode.system
      ? MediaQuery.of(this).platformBrightness
      : themeNotifier.themeMode == ThemeMode.light
          ? Brightness.light
          : Brightness.dark;
}
