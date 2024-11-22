import 'package:flutter/material.dart';

const colorSeed = Color(0xff424CB8);
const scaffoldBackgroundColor = Color(0xFFF8F7F7);

class AppTheme {
  ThemeData getDarkTheme() => ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorSchemeSeed: colorSeed,
      );
  ThemeData getLightTheme() => ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        colorSchemeSeed: colorSeed,
      );
}
