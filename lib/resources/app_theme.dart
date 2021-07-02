import 'package:flutter/material.dart';
import 'app_style.dart';

class AppTheme {
  static const Color textColorLight = Color(0xff0a255e);

  static final light = ThemeData(
    
    colorScheme: ColorScheme.light().copyWith(
      primary: Color(0xff1a5dea),
      secondary: Color(0xffe8effd),
      onSecondary: Color(0xff1241a4),
      //secondaryVariant: Color(0xff1241a4),
      error: Color(0xffff5959),
    ),
    // colorScheme: ColorScheme(
    //   primary: Colors.red,
    //   primaryVariant: Colors.blue, 
    //   secondary: Colors.blue,
    //   secondaryVariant: Colors.blue,
    //   surface: Colors.blue,
    //   background: Colors.blue,
    //   error: Colors.blue,
    //   onPrimary: Colors.blue,
    //   onSecondary: Colors.blue,
    //   onSurface: Colors.blue,
    //   onBackground: Colors.blue,
    //   onError: Colors.blue,
    //   brightness: Brightness.light,
    // ),

    primaryColorBrightness: Brightness.light, // Меняет цвет текста AppBar

    appBarTheme: AppBarTheme(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
    ),

    primaryTextTheme: TextTheme(
      headline6: TextStyle(
        color: textColorLight, // Цвет AppBar > title
      ),
    ),

    primaryIconTheme: IconThemeData(
      color: textColorLight, // Цвет AppBar > actions (icon color)
    ),

    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: AppStyle.borderRadius.md
      ),
    ),

    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.normal,
      height: 48.0,
    ),

    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: textColorLight,
      ),
      bodyText2: TextStyle(
        color: textColorLight,
      )
    )
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,

    appBarTheme: AppBarTheme(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
    ),

    // primaryTextTheme: TextTheme(
    //   headline6: TextStyle(
    //     color: Colors.white // Цвет AppBar > title
    //   ),
    // ),

    // primaryIconTheme: IconThemeData(
    //   color: Colors.white // Цвет AppBar > actions (icon color)
    // ),

    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: AppStyle.borderRadius.md
      ),
    ),

    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.normal,
      height: 48.0,
    ),
  );
}