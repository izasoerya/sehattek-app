import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: const Color.fromARGB(255, 235, 240, 247),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: Colors.black,
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        color: Colors.black54,
        fontSize: 10.sp,
        fontWeight: FontWeight.w600,
      ),
      bodySmall: TextStyle(color: Colors.black54, fontSize: 1.8.h),
      headlineLarge: TextStyle(
        color: Colors.black,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: Colors.black,
        fontSize: 14.sp,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.white),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
        textStyle: MaterialStateProperty.all<TextStyle>(
          TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 2.h, // Responsive font size
          ),
        ),
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: Colors.blue,
      secondary: Colors.white,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: Colors.white,
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(color: Colors.white, fontSize: 12.sp),
      bodySmall: TextStyle(color: Colors.white70, fontSize: 10.sp),
      headlineLarge: TextStyle(
        color: Colors.white,
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: Colors.white,
        fontSize: 12.sp,
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blue,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
