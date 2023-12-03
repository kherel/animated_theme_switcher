import 'package:flutter/material.dart';

abstract class ThemeSwitcherClipper {
  Path getClip(Size size, Offset offset, double sizeRate);

  bool shouldReclip(
      CustomClipper<Path> oldClipper, Offset offset, double sizeRate);
}
