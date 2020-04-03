import 'package:flutter/material.dart';

// this clipper used to animate a growing circle, after the theme switch.

class CircleClipper extends CustomClipper<Path> {
  CircleClipper({this.sizeRate, this.offset});
  final double sizeRate;
  final Offset offset;

  @override
  Path getClip(Size size) {
    // Because we are using a stack in main.dart
    // this size is the size of the whole screen;
    var path = Path()
      ..addOval(
        Rect.fromCircle(center: offset, radius: size.height * sizeRate),
      );

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
