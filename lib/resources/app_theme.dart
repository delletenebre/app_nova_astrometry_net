import 'package:flutter/material.dart';

class AppTheme {
  static const Color textColorLight = Color(0xff0a255e);
  static const Color primaryColorLight = Color(0xffac4d39);
  static const Color primaryColorDark = Color(0xffbd5e41);
  static const Color secondaryColor = Color(0xff7e392a);

  static final light = ThemeData(
    
    colorScheme: ColorScheme.light().copyWith(
      primary: primaryColorLight,
      onPrimary: Colors.white,
      secondary: secondaryColor,
      onSecondary: Colors.white,
      error: Color(0xffff5959),
    ),

    primaryColorBrightness: Brightness.light, // Меняет цвет текста AppBar

    appBarTheme: AppBarTheme(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: primaryColorLight,
      )
    ),
  );

  static final dark = ThemeData.dark().copyWith(

    colorScheme: ColorScheme.dark().copyWith(
      primary: primaryColorDark,
      onPrimary: Colors.white,
      secondary: secondaryColor,
      onSecondary: Colors.white,
      error: Color(0xffff5959),
    ),

    primaryColorBrightness: Brightness.dark, // Меняет цвет текста AppBar

    appBarTheme: AppBarTheme(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: primaryColorDark,
      )
    ),
  );
}