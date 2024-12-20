import 'package:flutter/material.dart';
import "features/login/index.dart";

void main() {
  runApp(MaterialApp(
    home: const LandingPage(),
    theme: AppThemes.lightTheme,
    darkTheme: AppThemes.darkTheme,
    themeMode: ThemeMode.system,

  ));
}

class AppColors {
  static const black = Colors.black;
  static const white = Colors.white;

}

class AppThemes {
  static final lightTheme = ThemeData(
    primaryColor: AppColors.white,
    brightness: Brightness.light
  );
  static final darkTheme = ThemeData(
    primaryColor: AppColors.black,
    brightness: Brightness.dark
  );
}
