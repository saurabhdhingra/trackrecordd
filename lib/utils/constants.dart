import 'package:flutter/material.dart';

class SizeConfig {
  static getHeight(context) {
    return MediaQuery.of(context).size.height;
  }

  static getWidth(context) {
    return MediaQuery.of(context).size.width;
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
      iconTheme: const IconThemeData(color: Colors.white),
      scaffoldBackgroundColor: Colors.black,
      primaryColor: const Color.fromRGBO(29, 28, 30, 1),
      colorScheme: const ColorScheme.dark().copyWith(secondary: Colors.white));
  static final lightTheme = ThemeData(
    iconTheme: const IconThemeData(color: Colors.black),
    scaffoldBackgroundColor: const Color.fromRGBO(243, 242, 247, 1),
    primaryColor: Colors.white,
    colorScheme: const ColorScheme.light().copyWith(secondary: Colors.black),
  );
}

