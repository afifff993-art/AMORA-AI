import 'package:flutter/material.dart';

import 'amora_colors.dart';

/// Material 3 themes for AMORA.
class AmoraTheme {
  AmoraTheme._();

  static ThemeData dark() {
    final scheme = ColorScheme.fromSeed(
      seedColor: AmoraColors.cyan,
      brightness: Brightness.dark,
    ).copyWith(
      primary: AmoraColors.cyan,
      secondary: AmoraColors.purple,
      surface: AmoraColors.surfaceDark,
      error: AmoraColors.error,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AmoraColors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: AmoraColors.lightAccent,
      brightness: Brightness.light,
    ).copyWith(
      primary: AmoraColors.lightAccent,
      secondary: AmoraColors.purple,
      surface: AmoraColors.lightSurface,
      error: AmoraColors.error,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AmoraColors.lightBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
