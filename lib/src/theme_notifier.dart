import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/rendering.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeNotifier({
    required ThemeModel themeModel,
    required this.controller,
  }) : _themeModel = themeModel;

  ThemeModel _themeModel;
  ui.Image? image;

  final GlobalKey containerKey = GlobalKey();

  ThemeSwitcherClipper clipper = const ThemeSwitcherCircleClipper();
  final AnimationController controller;

  ThemeData get lightTheme => _themeModel.lightTheme;
  ThemeData get darkTheme => _themeModel.darkTheme;
  ThemeMode get themeMode => _themeModel.themeMode;
  ThemeModel get themeModel => _themeModel;
  ThemeModel? oldThemeModel;

  bool isReversed = false;
  late Offset switcherOffset;

  void _switchTheme(
    ThemeModel themeModel,
  ) {
    oldThemeModel = _themeModel;
    _themeModel = themeModel;
  }

  void changeTheme({
    required ThemeModel themeModel,
    required GlobalKey key,
    ThemeSwitcherClipper? clipper,
    required bool isReversed,
    required bool animateTransition,
    Offset? offset,
    VoidCallback? onAnimationFinish,
  }) async {
    if (clipper != null) {
      this.clipper = clipper;
    }
    if (controller.isAnimating) {
      return;
    }
    if (!animateTransition) {
      _switchTheme(themeModel);
      notifyListeners();
      return;
    }

    this.isReversed = isReversed;
    _switchTheme(themeModel);

    switcherOffset = _getSwitcherCoordinates(key, offset);
    await _saveScreenshot();

    if (isReversed) {
      await controller
          .reverse(from: 1.0)
          .then((value) => onAnimationFinish?.call());
    } else {
      await controller
          .forward(from: 0.0)
          .then((value) => onAnimationFinish?.call());
    }
    // Notify listeners when the animation finishes.
    notifyListeners();
  }

  Future<void> _saveScreenshot() async {
    final boundary = containerKey.currentContext!.findRenderObject()
        as RenderRepaintBoundary;
    image = await boundary.toImage(
        pixelRatio: WidgetsBinding
            .instance.platformDispatcher.views.first.devicePixelRatio);
    notifyListeners();
  }

  Offset _getSwitcherCoordinates(
      GlobalKey<State<StatefulWidget>> switcherGlobalKey,
      [Offset? tapOffset]) {
    final renderObject =
        switcherGlobalKey.currentContext!.findRenderObject()! as RenderBox;
    final size = renderObject.size;
    return renderObject.localToGlobal(Offset.zero).translate(
          tapOffset?.dx ?? (size.width / 2),
          tapOffset?.dy ?? (size.height / 2),
        );
  }
}
