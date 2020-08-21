import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light();

ThemeData darkTheme = ThemeData.dark();

ThemeData pinkTheme = lightTheme.copyWith(
    primaryColor: Color(0xFFF49FB6),
    scaffoldBackgroundColor: Color(0xFFFAF8F0),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: Color(0xFF24737c),
      backgroundColor: Color(0xFFA6E0DE),
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        color: Colors.black87,
      ),
    ));

ThemeData halloweenTheme = lightTheme.copyWith(
  primaryColor: Color(0xFF55705A),
  scaffoldBackgroundColor: Color(0xFFE48873),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Color(0xFFea8e71),
    backgroundColor: Color(0xFF2b2119),
  ),
);

ThemeData darkBlueTheme = ThemeData.dark().copyWith(
  primaryColor: Color(0xFF1E1E2C),
  scaffoldBackgroundColor: Color(0xFF2D2D44),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: Color(0xFF33E1Ed),
    ),
  ),
);
