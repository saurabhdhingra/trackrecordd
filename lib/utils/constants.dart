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
    scaffoldBackgroundColor: Colors.black,
    primaryColor: const Color(0xFF1D1C1E), // Darker background color
    colorScheme: const ColorScheme.dark().copyWith(
      primary: Colors.black,
      secondary: Colors.white,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
      size: 24,
    ),
    appBarTheme: const AppBarTheme(
      color: Color(0xFF1D1C1E),
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 2,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(
          color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: Colors.white70, fontSize: 16),
      bodyMedium: TextStyle(color: Colors.white54, fontSize: 14),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      buttonColor: const Color(0xFFFED500),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[900],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.white),
      ),
      labelStyle: const TextStyle(color: Colors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: const Color(0xFFFED500),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFFED500),
      foregroundColor: Colors.black,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(Colors.white),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.yellow;
        }
        return Colors.grey;
      }),
    ),
    datePickerTheme: const DatePickerThemeData(
      backgroundColor: Colors.white,
      dayStyle: TextStyle(color: Colors.black),
      todayBackgroundColor: WidgetStatePropertyAll(Colors.yellow),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(Colors.black),
      ),
    ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFF3F2F7), // Light background color
    primaryColor: Colors.white,
    colorScheme: const ColorScheme.light().copyWith(
      primary: Colors.white,
      secondary: Colors.black,
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
      size: 24,
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      elevation: 2,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(
          color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: Colors.black87, fontSize: 16),
      bodyMedium: TextStyle(color: Colors.black54, fontSize: 14),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      buttonColor: const Color(0xFFFED500),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.black),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.black),
      ),
      labelStyle: const TextStyle(color: Colors.black),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: const Color(0xFFFED500),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFFED500),
      foregroundColor: Colors.black,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(Colors.white),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.yellow;
        }
        return Colors.grey;
      }),
    ),
    datePickerTheme: const DatePickerThemeData(
      backgroundColor: Colors.black,
      dayStyle: TextStyle(color: Colors.white),
      todayBackgroundColor: WidgetStatePropertyAll(Colors.yellow),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(Colors.white),
      ),
    ),
  );
}
