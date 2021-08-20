import 'package:flutter/material.dart';

ThemeData _themeLight = ThemeData.light();
ThemeData _themeDark = ThemeData.dark();

ThemeData themeLight = _themeLight.copyWith(
  appBarTheme: AppBarTheme(
    color: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      headline6: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
    ),
  ),
  backgroundColor: Colors.white,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      // foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      backgroundColor: MaterialStateProperty.all<Color>(
        Color.fromARGB(255, 255, 255, 255),
      ),
    ),
  ),
);

ThemeData themeDark = _themeDark.copyWith(
  appBarTheme: AppBarTheme(
    color: Colors.black,
    iconTheme: IconThemeData(color: Colors.white),
    textTheme: TextTheme(
      headline6: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
    ),
  ),
  backgroundColor: Color.fromARGB(255, 17, 17, 17),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        Color.fromARGB(255, 42, 42, 42),
      ),
    ),
  ),
);
