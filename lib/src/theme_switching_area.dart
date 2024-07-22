import 'package:flutter/material.dart';

import 'clippers/theme_switcher_clipper_bridge.dart';
import 'theme_provider.dart';

class ThemeSwitchingArea extends StatelessWidget {
  ThemeSwitchingArea({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = ThemeModelInheritedNotifier.of(context);

    final correctTheme = themeNotifier.themeModel.themeMode == ThemeMode.system
        ? MediaQuery.of(context).platformBrightness == Brightness.dark
            ? themeNotifier.themeModel.darkTheme
            : themeNotifier.themeModel.lightTheme
        : themeNotifier.themeModel.themeMode == ThemeMode.light
            ? themeNotifier.themeModel.lightTheme
            : themeNotifier.themeModel.darkTheme;

    Widget _child;
    if (themeNotifier.oldThemeModel == null ||
        themeNotifier.oldThemeModel == themeNotifier.themeModel ||
        !themeNotifier.controller.isAnimating) {
      _child = _applyTheme(correctTheme);
    } else {
      late final Widget firstWidget, animWidget;
      if (themeNotifier.isReversed) {
        firstWidget = _applyTheme(correctTheme);
        animWidget = RawImage(image: themeNotifier.image);
      } else {
        firstWidget = RawImage(image: themeNotifier.image);
        animWidget = _applyTheme(correctTheme);
      }
      _child = Stack(
        children: [
          Container(
            key: ValueKey('ThemeSwitchingAreaFirstChild'),
            child: firstWidget,
          ),
          AnimatedBuilder(
            key: ValueKey('ThemeSwitchingAreaSecondChild'),
            animation: themeNotifier.controller,
            child: animWidget,
            builder: (_, child) {
              return ClipPath(
                clipper: ThemeSwitcherClipperBridge(
                  clipper: themeNotifier.clipper,
                  offset: themeNotifier.switcherOffset,
                  sizeRate: themeNotifier.controller.value,
                ),
                child: child,
              );
            },
          ),
        ],
      );
    }

    return Material(child: _child);
  }

  Widget _applyTheme(ThemeData theme) {
    return Theme(
      key: ValueKey('ThemeSwitchingAreaPage'),
      data: theme,
      child: child,
    );
  }
}
