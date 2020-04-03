import 'package:flutter/material.dart';
import 'brand_theme_model.dart';

// In this config file, I'm configuration the themes, usualy I have several folder in my projects
// config, logic, ui. 

ThemeData defaultThemeData = ThemeData(
  // I changed FAB button form, only as example that you can configurate MaterialTheme too..
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    shape: RoundedRectangleBorder(),
  ),
);

BrandThemeModel lightBrandTheme = BrandThemeModel(
  brightness: Brightness.light,
  color1: Colors.blue,
  color2: Colors.white,
  textColor1: Colors.black,
  textColor2: Colors.white,
  themeData: defaultThemeData,
);

BrandThemeModel darkBrandTheme = BrandThemeModel(
  brightness: Brightness.dark,
  color1: Colors.red,
  color2: Colors.black,
  textColor1: Colors.blue,
  textColor2: Colors.yellow,
  themeData: defaultThemeData,
);
