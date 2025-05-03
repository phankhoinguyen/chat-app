import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ThemeData lightMode = ThemeData(
//   colorScheme: ColorScheme.light(
//     background:
//   )
// )
final colorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF03045E),
).copyWith(
  primary: const Color(0xFF03045E), // Màu chủ đạo
  secondary: const Color(0xFF0077B6), // Màu phụ
  tertiary: const Color(0xFF00B4D8), // Màu đặc biệt (accent)
  background: const Color(0xFF90E0EF), // Nền tổng thể (Scaffold)
  surface: const Color(0xFFCAF0F8), // Nền card, dialog
  error: Colors.red, // Mặc định
);
final lightMode = ThemeData.light().copyWith(
  scaffoldBackgroundColor: colorScheme.surface,
  appBarTheme: AppBarTheme(
    backgroundColor: colorScheme.surface,
    centerTitle: true,
    titleTextStyle: const TextStyle(
      fontFamily: 'Cedora',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),
  colorScheme: colorScheme,
  brightness: Brightness.light,
  textTheme: GoogleFonts.robotoCondensedTextTheme(),
);
