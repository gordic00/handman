import 'package:flutter/material.dart';

class AppTheme {
  static final appTheme = ThemeData(
      primaryColor: Colors.lightBlue,
      scaffoldBackgroundColor: Colors.lightBlue,
      brightness: Brightness.light,
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: Colors.lightBlue,
        contentTextStyle: TextStyle(color: Colors.white),
      ),
      inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xffF5F9FE),
          hintStyle: const TextStyle(
            color: Colors.lightBlue,
            fontWeight: FontWeight.w400,
          ),
          contentPadding: const EdgeInsets.all(16),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none)),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              elevation: 0,
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)))));
}
