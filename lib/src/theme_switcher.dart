import 'package:animated_theme_switcher/src/extension/theme_provider_extension.dart';
import 'package:flutter/material.dart';

import 'clippers/theme_switcher_circle_clipper.dart';
import 'clippers/theme_switcher_clipper.dart';
import 'models/theme_model.dart';
import 'theme_notifier.dart';
import 'theme_provider.dart';

typedef ChangeTheme = void Function(ThemeData theme);
typedef BuilderWithSwitcher = Widget Function(
    BuildContext, ThemeSwitcherState switcher);
typedef BuilderWithThemeModel = Widget Function(
    BuildContext, ThemeSwitcherState switcher, ThemeModel themeModel);

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({
    Key? key,
    this.clipper = const ThemeSwitcherCircleClipper(),
    required this.builder,
  }) : super(key: key);

  factory ThemeSwitcher.switcher({
    Key? key,
    clipper = const ThemeSwitcherCircleClipper(),
    required BuilderWithSwitcher builder,
  }) =>
      ThemeSwitcher(
        key: key,
        clipper: clipper,
        builder: (ctx) => builder(ctx, ThemeSwitcher.of(ctx)),
      );

  factory ThemeSwitcher.withThemeModel({
    Key? key,
    clipper = const ThemeSwitcherCircleClipper(),
    required BuilderWithThemeModel builder,
  }) =>
      ThemeSwitcher.switcher(
        key: key,
        clipper: clipper,
        builder: (ctx, s) =>
            builder(ctx, s, ThemeModelInheritedNotifier.of(ctx).themeModel),
      );

  final Widget Function(BuildContext) builder;
  final ThemeSwitcherClipper clipper;

  @override
  ThemeSwitcherState createState() => ThemeSwitcherState();

  static ThemeSwitcherState of(BuildContext context) {
    final inherited =
        context.dependOnInheritedWidgetOfExactType<_InheritedThemeSwitcher>()!;
    return inherited.data;
  }
}

class ThemeSwitcherState extends State<ThemeSwitcher> {
  final GlobalKey _globalKey = GlobalKey();
  ThemeNotifier get themeNotifier => ThemeModelInheritedNotifier.of(context);

  @override
  Widget build(BuildContext context) {
    return _InheritedThemeSwitcher(
      data: this,
      child: Builder(
        key: _globalKey,
        builder: widget.builder,
      ),
    );
  }

  void toggleThemeMode({
    bool animateTransition = true,
    Offset? offset,
    VoidCallback? onAnimationFinish,
    bool isReversed = false,
  }) {
    themeNotifier.changeTheme(
        themeModel: context.brightness == Brightness.dark
            ? themeNotifier.themeModel.copyWith(themeMode: ThemeMode.light)
            : themeNotifier.themeModel.copyWith(themeMode: ThemeMode.dark),
        key: _globalKey,
        clipper: widget.clipper,
        animateTransition: animateTransition,
        offset: offset,
        onAnimationFinish: onAnimationFinish,
        isReversed: isReversed);
  }

  void updateThemeMode({
    required ThemeMode themeMode,
    bool animateTransition = true,
    Offset? offset,
    VoidCallback? onAnimationFinish,
    bool isReversed = false,
  }) {
    themeNotifier.changeTheme(
        themeModel: themeNotifier.themeModel.copyWith(themeMode: themeMode),
        key: _globalKey,
        clipper: widget.clipper,
        animateTransition: animateTransition,
        offset: offset,
        onAnimationFinish: onAnimationFinish,
        isReversed: isReversed);
  }

  void updateTheme({
    ThemeData? lightTheme,
    ThemeData? darkTheme,
    bool isReversed = false,
    bool animateTransition = false,
    Offset? offset,
    VoidCallback? onAnimationFinish,
  }) {
    if (lightTheme == null && darkTheme == null) {
      return;
    }

    themeNotifier.changeTheme(
        themeModel: themeNotifier.themeModel.copyWith(
          lightTheme: lightTheme,
          darkTheme: darkTheme,
        ),
        key: _globalKey,
        clipper: widget.clipper,
        animateTransition: animateTransition,
        isReversed: isReversed,
        offset: offset,
        onAnimationFinish: onAnimationFinish);
  }
}

class _InheritedThemeSwitcher extends InheritedWidget {
  final ThemeSwitcherState data;

  _InheritedThemeSwitcher({
    required this.data,
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedThemeSwitcher oldWidget) {
    return true;
  }
}
