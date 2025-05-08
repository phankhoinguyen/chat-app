import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final darkColorScheme = const ColorScheme.dark().copyWith(
  primary: Colors.white, // Text chính màu trắng
  secondary: Colors.grey, // Text phụ màu xám
  tertiary: Colors.blueGrey, // Accent xám-xanh nhẹ
  background: const Color(0xFF121212), // Nền chung
  surface: const Color(0xFF1E1E1E), // Card, AppBar
  error: Colors.red,
);

final darkMode = ThemeData.dark().copyWith(
  dividerTheme: DividerThemeData(color: darkColorScheme.surface),
  colorScheme: darkColorScheme,
  scaffoldBackgroundColor: darkColorScheme.surface,
  appBarTheme: AppBarTheme(
    backgroundColor: darkColorScheme.surface,
    centerTitle: true,
    titleTextStyle: const TextStyle(
      fontFamily: 'Cedora',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  // dividerTheme: DividerThemeData(color: darkColorScheme.background),
  textTheme: GoogleFonts.robotoCondensedTextTheme(ThemeData.dark().textTheme),
);
