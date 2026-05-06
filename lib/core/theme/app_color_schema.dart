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
  final Color background;
  final Color success;

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
    required this.background,
    required this.success,
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
    Color? background,
    Color? success,
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
      divider: divider ?? this.divider,
      background: background ?? this.background,
      secondary: secondary ?? this.secondary,
      success: success ?? this.success,
    );
  }

  @override
  AppColorScheme lerp(ThemeExtension<AppColorScheme>? other, double t) {
    if (other is! AppColorScheme) return this;
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
      divider: Color.lerp(divider, other.divider, t)!,
      background: Color.lerp(background, other.background, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      success: Color.lerp(success, other.success, t)!,
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
    divider: Color(0xFFE5E7EB),
    background: Color(0xFFF9FAFB),
    secondary: Color(0xFFDBEAFE),
    success: Color(0xFF10B981),
  );

  static const AppColorScheme dark = AppColorScheme(
    primary: Color(0xFF4A6CF7),
    primaryLight: Color(0xFF6B8EFF),
    scaffoldBg: Color(0xFF111827),
    surface: Color(0xFF1F2937),
    textPrimary: Color(0xFFF9FAFB),
    textSecondary: Color(0xFF9CA3AF),
    textHint: Color(0xFF6B7280),
    // Fixed: dark-appropriate backgrounds (deep navy tones, not light blues)
    ongoingBg: Color(0xFF1E3A5F),
    ongoingText: Color(0xFF93B4FF),
    completedBg: Color(0xFF064E3B),
    completedText: Color(0xFF34D399),
    divider: Color(0xFF374151),
    background: Color(0xFF111827),
    secondary: Color(0xFF1E3A8A),
    success: Color(0xFF059669),
  );

  static const gradient = LinearGradient(
    colors: [Color(0xFF4A6CF7), Color(0xFF2D4B73)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}