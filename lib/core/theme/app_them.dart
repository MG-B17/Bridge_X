import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_color_scheme.dart';
import 'text_style.dart';

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
        textTheme: TextTheme(
          displayLarge: AppTextStyles.displayLarge.copyWith(
            color: AppColorScheme.light.textPrimary,
          ),
          headlineMedium: AppTextStyles.headlineMedium.copyWith(
            color: AppColorScheme.light.textPrimary,
          ),
          titleLarge: AppTextStyles.titleLarge.copyWith(
            color: AppColorScheme.light.textPrimary,
          ),
          bodyLarge: AppTextStyles.bodyLarge.copyWith(
            color: AppColorScheme.light.textPrimary,
          ),
          bodyMedium: AppTextStyles.bodyMedium.copyWith(
            color: AppColorScheme.light.textPrimary,
          ),
          labelSmall: AppTextStyles.labelSmall.copyWith(
            color: AppColorScheme.light.textSecondary,
          ),
        ),
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
        textTheme: TextTheme(
          displayLarge: AppTextStyles.displayLarge.copyWith(
            color: AppColorScheme.dark.textPrimary,
          ),
          headlineMedium: AppTextStyles.headlineMedium.copyWith(
            color: AppColorScheme.dark.textPrimary,
          ),
          titleLarge: AppTextStyles.titleLarge.copyWith(
            color: AppColorScheme.dark.textPrimary,
          ),
          bodyLarge: AppTextStyles.bodyLarge.copyWith(
            color: AppColorScheme.dark.textPrimary,
          ),
          bodyMedium: AppTextStyles.bodyMedium.copyWith(
            color: AppColorScheme.dark.textPrimary,
          ),
          labelSmall: AppTextStyles.labelSmall.copyWith(
            color: AppColorScheme.dark.textSecondary,
          ),
        ),
        extensions: [AppColorScheme.dark],
      );
}
