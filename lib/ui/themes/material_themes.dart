import 'package:flutter/material.dart';

ThemeData _themeLight = ThemeData.light();
ThemeData _themeDark = ThemeData.dark();

ThemeData themeLight = _themeLight.copyWith(
  primaryColor: Color.fromARGB(255, 0, 138, 94),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
    // textTheme: TextTheme(
    //   headline6: TextStyle(
    //       color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
    // ),
  ),
  colorScheme: ColorScheme(
    primary: Color.fromARGB(255, 0, 138, 94),
    primaryVariant: Colors.black,
    secondary: Colors.black,
    secondaryVariant: Colors.black,
    surface: Colors.black,
    background: Colors.black,
    error: Colors.red,
    onPrimary: Color.fromARGB(255, 0, 138, 94),
    onSecondary: Colors.black,
    onSurface: Colors.black,
    onBackground: Colors.black,
    onError: Colors.black,
    brightness: Brightness.light,
  ),
  backgroundColor: Colors.white,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      // foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      // textStyle: MaterialStateProperty.all(TextStyle(color: Colors.black)),
      backgroundColor: MaterialStateProperty.all<Color>(
        Colors.white,
      ),
      // shadowColor: MaterialStateProperty.all<Color>(
      //   Color.fromRGBO(255, 255, 255, 0),
      // ),
    ),
  ),
);

ThemeData themeDark = _themeDark.copyWith(
  appBarTheme: AppBarTheme(
    color: Colors.black,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
  ),
  backgroundColor: Color.fromARGB(255, 17, 17, 17),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        Color.fromARGB(255, 42, 42, 42),
      ),
    ),
  ),
  colorScheme: ColorScheme(
    primary: Color.fromARGB(255, 0, 138, 94),
    primaryVariant: Colors.black,
    secondary: Colors.black,
    secondaryVariant: Colors.black,
    surface: Colors.black,
    background: Colors.black,
    error: Colors.red,
    onPrimary: Color.fromARGB(255, 0, 138, 94),
    onSecondary: Colors.white,
    onSurface: Colors.white,
    onBackground: Colors.white,
    onError: Colors.white,
    brightness: Brightness.dark,
  ),
);
