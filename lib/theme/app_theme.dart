import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xffDFECDB),
    primaryColor: const Color(0xff5D9CEC),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xff5D9CEC),
      type: BottomNavigationBarType.fixed,
    ),
  );
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xff141922),
    primaryColor: const Color(0xff5D9CEC),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xff707070),
      selectedItemColor: Color(0xff5D9CEC),
      type: BottomNavigationBarType.fixed,
    ),
  );
}
