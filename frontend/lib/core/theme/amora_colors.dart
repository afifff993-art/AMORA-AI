import 'package:flutter/material.dart';

/// Original AMORA colour palette (deep black, electric cyan, blue, purple).
class AmoraColors {
  AmoraColors._();

  static const Color black = Color(0xFF020409);
  static const Color surfaceDark = Color(0xFF0A1220);
  static const Color cyan = Color(0xFF00E5FF);
  static const Color blue = Color(0xFF2979FF);
  static const Color purple = Color(0xFF9C6BFF);
  static const Color error = Color(0xFFFF4D6D);

  static const Color lightBackground = Color(0xFFF2F7FC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightInk = Color(0xFF0B1B2E);
  // Cyan is too bright on white, so light mode uses a deeper accent.
  static const Color lightAccent = Color(0xFF0086B3);
}
