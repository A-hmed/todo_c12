import 'package:flutter/material.dart';

abstract class AppTheme {
  static Color primaryColor = const Color(0xff5D9CEC);
  static Color darkGray = const Color(0xff200E32);

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xffDFECDB),
    primaryColor: primaryColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primaryColor,
      type: BottomNavigationBarType.fixed,
    ),
    textTheme: TextTheme(
        titleMedium: TextStyle(
            color: primaryColor, fontSize: 18, fontWeight: FontWeight.bold),
        titleSmall: TextStyle(
            color: darkGray, fontSize: 12, fontWeight: FontWeight.w400)),
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
