import 'package:flutter/material.dart';
import 'brand_theme_model.dart';

// In this config file, I'm configuration the themes, usualy I have several
// folder in my projects
// config, logic, ui.

// default lightTheme with customized FAB button form, only as example that you
// can configurate MaterialTheme too..
ThemeData defaultThemeData = ThemeData.light().copyWith(
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    shape: RoundedRectangleBorder(),
  ),
);

// darkTheme for app, you can change it as you want
final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  cardColor: Color(0xFF212121),
  backgroundColor: Colors.black,
  accentColor: Colors.white,
  dividerColor: Colors.black12,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    shape: RoundedRectangleBorder(),
  ),
);

BrandThemeModel lightBrandTheme = BrandThemeModel(
  brightness: Brightness.light,
  themeData: defaultThemeData,
);

BrandThemeModel darkBrandTheme = BrandThemeModel(
  brightness: Brightness.dark,
  themeData: darkTheme,
);
