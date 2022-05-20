import 'package:erp_app/style/my_color.dart';
import 'package:flutter/material.dart';

class MyTheme {
  static const bool _isLightMode = true;
  static bool get isLightMode => _isLightMode;
  static ThemeData lightTheme() {
    return ThemeData(
      backgroundColor: MyColors.backgroundColor,
      primaryColor: MyColors.primaryColor,
      accentColor: MyColors.textColor,
      secondaryHeaderColor: MyColors.secondaryColor,
      dividerColor: MyColors.dividerColor,
      textTheme: const TextTheme(
        button: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        headline1: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        headline2: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        headline3: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        headlineLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: MyColors.textColor,
        ),
        headline4: TextStyle(
          color: MyColors.textColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        headline5: TextStyle(
          color: MyColors.textColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        caption: TextStyle(
          color: MyColors.backgroundColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        subtitle1: TextStyle(
          color: MyColors.backgroundColor,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        subtitle2: TextStyle(
          color: MyColors.textColor,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
