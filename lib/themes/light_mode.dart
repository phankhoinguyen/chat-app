import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ThemeData lightMode = ThemeData(
//   colorScheme: ColorScheme.light(
//     background:
//   )
// )
final lightMode = ThemeData.light().copyWith(
  colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF03045E)).copyWith(
    primary: Color(0xFF03045E), // Màu chủ đạo
    secondary: Color(0xFF0077B6), // Màu phụ
    tertiary: Color(0xFF00B4D8), // Màu đặc biệt (accent)
    background: Color(0xFF90E0EF), // Nền tổng thể (Scaffold)
    surface: Color(0xFFCAF0F8), // Nền card, dialog
    error: Colors.red, // Mặc định
  ),
  brightness: Brightness.light,
  textTheme: GoogleFonts.robotoCondensedTextTheme(),
);
