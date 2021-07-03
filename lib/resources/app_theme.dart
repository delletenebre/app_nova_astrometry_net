import 'package:flutter/material.dart';

class AppTheme {
  static const Color textColorLight = Color(0xff0a255e);
  static const Color primaryColorLight = Color(0xffac4d39);
  static const Color primaryColorDark = Color(0xffbd5e41);

  static final light = ThemeData(
    
    colorScheme: ColorScheme.light().copyWith(
      primary: primaryColorLight,
      onPrimary: Colors.white,
      secondary: Color(0xff7e392a),
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

    // primaryTextTheme: TextTheme(
    //   headline6: TextStyle(
    //     color: textColorLight, // Цвет AppBar > title
    //   ),
    // ),

    // primaryIconTheme: IconThemeData(
    //   color: textColorLight, // Цвет AppBar > actions (icon color)
    // ),

    // cardTheme: CardTheme(
    //   shape: RoundedRectangleBorder(
    //     borderRadius: const BorderRadius.all(Radius.circular(16))
    //   ),
    // ),

    // buttonTheme: ButtonThemeData(
    //   textTheme: ButtonTextTheme.normal,
    //   height: 48.0,
    // ),

    // textTheme: TextTheme(
    //   headline1: TextStyle(
    //     fontSize: 20,
    //     fontWeight: FontWeight.bold,
    //     color: textColorLight,
    //   ),
    //   bodyText2: TextStyle(
    //     color: textColorLight,
    //   )
    // )
  );

  static final dark = ThemeData.dark().copyWith(

    colorScheme: ColorScheme.dark().copyWith(
      primary: primaryColorDark,
      onPrimary: Colors.white,
      secondary: Color(0xff7e392a),
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