import 'package:flutter/material.dart';
import 'package:todo_c12/module/splash/splash_screen.dart';
import 'package:todo_c12/theme/app_theme.dart';

import 'module/layout/layout_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        LayoutScreen.routeName: (_) => LayoutScreen(),
      },
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: SplashScreen.routeName,
    );
  }
}
