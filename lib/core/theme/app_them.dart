import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_color_scheme.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColorScheme.light.scaffoldBg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColorScheme.light.primary,
          surface: AppColorScheme.light.surface,
          brightness: Brightness.light,
        ),
        fontFamily: GoogleFonts.inter().fontFamily,
        extensions: [AppColorScheme.light],
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColorScheme.dark.scaffoldBg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColorScheme.dark.primary,
          surface: AppColorScheme.dark.surface,
          brightness: Brightness.dark,
        ),
        fontFamily: GoogleFonts.inter().fontFamily,
        extensions: [AppColorScheme.dark],
      );
}
