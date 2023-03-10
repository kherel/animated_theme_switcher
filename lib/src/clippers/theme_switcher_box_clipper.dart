import 'package:flutter/material.dart';
import 'theme_switcher_clipper.dart';

@immutable
class ThemeSwitcherBoxClipper implements ThemeSwitcherClipper {
  const ThemeSwitcherBoxClipper();

  @override
  Path getClip(Size size, Offset offset, double sizeRate) {
    return Path()
      ..addRect(
        Rect.fromCenter(
          center: offset,
          width: size.width * 2 * sizeRate,
          height: size.height * 2 * sizeRate,
        ),
      );
  }

  @override
  bool shouldReclip(
      CustomClipper<Path> oldClipper, Offset? offset, double? sizeRate) {
    return true;
  }
}
