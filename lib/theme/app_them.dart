import 'package:flutter/material.dart';

//List of available themes
enum AppThemeType { light, dark, oled }

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    primaryColor: Colors.blue,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
    colorScheme: const ColorScheme.light(
      primary: Colors.blue,
      secondary: Colors.green,
      tertiary: Colors.orangeAccent,
      error: Colors.red,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),
    primaryColor: Colors.blueAccent,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
    ),
    colorScheme: const ColorScheme.dark(
      primary: Colors.blueAccent,
      secondary: Colors.green,
      tertiary: Colors.orangeAccent,
      error: Colors.redAccent,
    ),
  );

  static final ThemeData oledTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black, // absolute black
    primaryColor: Colors.cyanAccent,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
    ),
    colorScheme: const ColorScheme.dark(
      primary: Colors.cyanAccent,
      secondary: Colors.green,
      tertiary: Colors.orangeAccent,
      error: Colors.redAccent,
    ),
  );

/// Helper method to get ThemeData by Enum
  static ThemeData getTheme(AppThemeType type) {
    switch (type) {
      case AppThemeType.light:
        return lightTheme;
      case AppThemeType.oled:
        return oledTheme;
      case AppThemeType.dark:
      default:
        return darkTheme;
    }
  }
}