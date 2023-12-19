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
    final model = ThemeModelInheritedNotifier.of(context);
    // Widget resChild;
    Widget child;
    if (model.oldTheme == null ||
        model.oldTheme == model.theme ||
        !model.controller.isAnimating) {
      child = _getPage(model.theme);
    } else {
      late final Widget firstWidget, animWidget;
      if (model.isReversed) {
        firstWidget = _getPage(model.theme);
        animWidget = RawImage(image: model.image);
      } else {
        firstWidget = RawImage(image: model.image);
        animWidget = _getPage(model.theme);
      }
      child = Stack(
        children: [
          Container(
            key: ValueKey('ThemeSwitchingAreaFirstChild'),
            child: firstWidget,
          ),
          AnimatedBuilder(
            key: ValueKey('ThemeSwitchingAreaSecondChild'),
            animation: model.controller,
            child: animWidget,
            builder: (_, child) {
              return ClipPath(
                clipper: ThemeSwitcherClipperBridge(
                  clipper: model.clipper,
                  offset: model.switcherOffset,
                  sizeRate: model.controller.value,
                ),
                child: child,
              );
            },
          ),
        ],
      );
    }

    return Material(child: child);
  }

  Widget _getPage(ThemeData brandTheme) {
    return Theme(
      key: ValueKey('ThemeSwitchingAreaPage'),
      data: brandTheme,
      child: child,
    );
  }
}
