import 'package:flutter/material.dart';

class CircleClipper extends CustomClipper<Path> {
  CircleClipper({this.sizeRate, this.offset});

  final double sizeRate;
  final Offset offset;

  @override
  Path getClip(Size size) {
    var path = Path()
      ..addOval(
        Rect.fromCircle(center: offset, radius: size.height * sizeRate),
      );

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
