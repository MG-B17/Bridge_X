import 'package:flutter/material.dart';

class AppColorScheme extends ThemeExtension<AppColorScheme> {
  final Color primary;
  final Color primaryLight;
  final Color scaffoldBg;
  final Color surface;
  final Color textPrimary;
  final Color textSecondary;
  final Color textHint;
  final Color ongoingBg;
  final Color ongoingText;
  final Color completedBg;
  final Color completedText;
  final Color secondary;
  final Color divider;

  const AppColorScheme({
    required this.primary,
    required this.primaryLight,
    required this.scaffoldBg,
    required this.surface,
    required this.textPrimary,
    required this.textSecondary,
    required this.textHint,
    required this.ongoingBg,
    required this.ongoingText,
    required this.completedBg,
    required this.completedText,
    required this.secondary,
    required this.divider,
  });

  @override
  AppColorScheme copyWith({
    Color? primary,
    Color? primaryLight,
    Color? scaffoldBg,
    Color? surface,
    Color? textPrimary,
    Color? textSecondary,
    Color? textHint,
    Color? ongoingBg,
    Color? ongoingText,
    Color? completedBg,
    Color? completedText,
    Color? secondary,
    Color? divider,
  }) {
    return AppColorScheme(
      primary: primary ?? this.primary,
      primaryLight: primaryLight ?? this.primaryLight,
      scaffoldBg: scaffoldBg ?? this.scaffoldBg,
      surface: surface ?? this.surface,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textHint: textHint ?? this.textHint,
      ongoingBg: ongoingBg ?? this.ongoingBg,
      ongoingText: ongoingText ?? this.ongoingText,
      completedBg: completedBg ?? this.completedBg,
      completedText: completedText ?? this.completedText,
      secondary: secondary ?? this.secondary,
      divider: divider ?? this.divider,
    );
  }

  @override
  AppColorScheme lerp(ThemeExtension<AppColorScheme>? other, double t) {
    if (other is! AppColorScheme) {
      return this;
    }
    return AppColorScheme(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryLight: Color.lerp(primaryLight, other.primaryLight, t)!,
      scaffoldBg: Color.lerp(scaffoldBg, other.scaffoldBg, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textHint: Color.lerp(textHint, other.textHint, t)!,
      ongoingBg: Color.lerp(ongoingBg, other.ongoingBg, t)!,
      ongoingText: Color.lerp(ongoingText, other.ongoingText, t)!,
      completedBg: Color.lerp(completedBg, other.completedBg, t)!,
      completedText: Color.lerp(completedText, other.completedText, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
    );
  }

  static const AppColorScheme light = AppColorScheme(
    primary: Color(0xFF2D4B73),
    primaryLight: Color(0xFF4A6CF7),
    scaffoldBg: Color(0xFFF9FAFB),
    surface: Color(0xFFFFFFFF),
    textPrimary: Color(0xFF111827),
    textSecondary: Color(0xFF6B7280),
    textHint: Color(0xFF9CA3AF),
    ongoingBg: Color(0xFFE7F0FF),
    ongoingText: Color(0xFF2D4B73),
    completedBg: Color(0xFFE7F7F2),
    completedText: Color(0xFF0E9F6E),
    secondary: Color(0xFF6B7280),
    divider: Color(0xFFE5E7EB),
  );

  static const AppColorScheme dark = AppColorScheme(
    primary: Color(0xFF4A6CF7),
    primaryLight: Color(0xFF4A6CF7),
    scaffoldBg: Color(0xFF111827),
    surface: Color(0xFF1F2937),
    textPrimary: Color(0xFFF9FAFB),
    textSecondary: Color(0xFF9CA3AF),
    textHint: Color(0xFF9CA3AF),
    ongoingBg: Color(0xFFE7F0FF),
    ongoingText: Color(0xFF4A6CF7),
    completedBg: Color(0xFFE7F7F2),
    completedText: Color(0xFF0E9F6E),
    secondary: Color(0xFF9CA3AF),
    divider: Color(0xFF374151),
  );

  static const gradient = LinearGradient(
    colors: [Color(0xFF4A6CF7), Color(0xFF2D4B73)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
