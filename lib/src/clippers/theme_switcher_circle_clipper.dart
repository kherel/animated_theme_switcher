import 'dart:math';
import 'dart:ui';
import 'theme_switcher_clipper.dart';
import 'package:flutter/material.dart';

@immutable
class ThemeSwitcherCircleClipper implements ThemeSwitcherClipper {
  const ThemeSwitcherCircleClipper();

  @override
  Path getClip(Size size, Offset? offset, double? sizeRate) {
    return Path()
      ..addOval(
        Rect.fromCircle(
          center: offset!,
          radius: lerpDouble(0, _calcMaxRadius(size, offset), sizeRate!)!,
        ),
      );
  }

  @override
  bool shouldReclip(
      CustomClipper<Path> oldClipper, Offset? offset, double? sizeRate) {
    return true;
  }

  static double _calcMaxRadius(Size size, Offset center) {
    final w = max(center.dx, size.width - center.dx);
    final h = max(center.dy, size.height - center.dy);
    return sqrt(w * w + h * h);
  }
}
