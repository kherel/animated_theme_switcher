import 'clippers/theme_switcher_clipper_bridge.dart';
import 'theme_provider.dart';
import 'package:flutter/material.dart';

class ThemeSwitchingArea extends StatelessWidget {
  ThemeSwitchingArea({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;
  //one more key to save drawer state
  final _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final model = ThemeModelInheritedNotifier.of(context);
    Widget resChild;
    if (model.oldTheme == null || model.oldTheme == model.theme) {
      resChild = _getPage(model.theme);
    } else {
      Widget firstWidget, animWidget;

      if (model.isReverse) {
        firstWidget = _getPage(model.theme);
        animWidget = RawImage(image: model.image);
      } else {
        firstWidget = RawImage(image: model.image);
        animWidget = _getPage(model.theme);
      }

      resChild = Stack(
        children: [
          firstWidget,
          AnimatedBuilder(
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

    return Material(child: resChild);
  }

  Widget _getPage(ThemeData brandTheme) {
    return Theme(
      key: _globalKey,
      data: brandTheme,
      child: child,
    );
  }
}
