import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// This is Brand theme model, BrandThemeModel is a data object class,
// it means that it doesn't do any operations, only storage the data.
// In this case colors, and braghness value, it could easyly extanded.

// The reason why I created new class, and not just used ThemeData class,
// When you change ThemeData in MaterialApp, it has their own animation.
// Plus I'm using this model in my projects and usualy I'm more comfortable
// using more colors, than Material Design has by default.

class BrandThemeModel extends Equatable {
  final ThemeData themeData;

  // Brighntess is enum, and only consist 2 values, dark and light.
  final Brightness brightness;

  BrandThemeModel({
    @required this.brightness,
    @required themeData,
  }) : this.themeData =
            themeData != null ? themeData : ThemeData(brightness: brightness);

  @override
  List<Object> get props => [
        themeData,
        brightness,
      ];
}
