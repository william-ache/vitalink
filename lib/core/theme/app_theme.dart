import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/app_config.dart';

class AppTheme {
  // Brand Design System Colors
  static const Color primaryTeal = Color(0xFF0D9488);    // Teal
  static const Color secondaryGreen = Color(0xFF4ADE80); // Light Green
  static const Color tertiaryRust = Color(0xFFC36D4B);   // Rust / Orange
  static const Color neutralGray = Color(0xFF737877);    // Neutral Gray
  static const Color softBackground = Color(0xFFF8FAFC);
  static const Color surfaceWhite = Colors.white;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryTeal,
        primary: primaryTeal,
        secondary: secondaryGreen,
        tertiary: tertiaryRust,
        surface: surfaceWhite,
        onSurface: primaryTeal,
      ),
      scaffoldBackgroundColor: softBackground,
      textTheme: _textTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: primaryTeal,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: primaryTeal,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.grey.shade100),
        ),
        color: surfaceWhite,
      ),
    );
  }

  static TextTheme get _textTheme {
    return GoogleFonts.interTextTheme().copyWith(
      displayLarge: GoogleFonts.manrope(
        fontSize: 28 * AppConfig.fontScale,
        fontWeight: FontWeight.w800,
        color: primaryTeal,
        letterSpacing: -0.5,
      ),
      titleLarge: GoogleFonts.manrope(
        fontSize: 22 * AppConfig.fontScale,
        fontWeight: FontWeight.bold,
        color: primaryTeal,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16 * AppConfig.fontScale,
        color: Colors.black87,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14 * AppConfig.fontScale,
        color: neutralGray,
      ),
    );
  }

  static ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryTeal,
        foregroundColor: surfaceWhite,
        minimumSize: Size(double.infinity, AppConfig.dynamicButtonHeight),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16 * AppConfig.fontScale,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
