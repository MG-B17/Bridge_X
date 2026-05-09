import 'package:bridge_x/core/theme/bridge_x_colors.dart';
import 'package:flutter/material.dart';


class AppColorScheme extends ThemeExtension<AppColorScheme> {
  // ── Core Brand ─────────────────────────────────────────────────────────────
  final Color primary; // Main action color
  final Color primaryLight; // Light tint of primary (backgrounds, chips)
  final Color secondary; // Accent / supporting colour
  final Color accent; // Highlight (burgundy in light / gold in dark)

  // ── Surfaces ───────────────────────────────────────────────────────────────
  final Color scaffoldBg; // Page background
  final Color background; // Slightly off-white / section background
  final Color surface; // Card / modal background
  final Color divider; // Border / separator lines

  // ── Text ───────────────────────────────────────────────────────────────────
  final Color textPrimary;
  final Color textSecondary;
  final Color textHint;

  // ── Status Tags ────────────────────────────────────────────────────────────
  final Color ongoingBg;
  final Color ongoingText;
  final Color completedBg;
  final Color completedText;

  // ── Semantic ───────────────────────────────────────────────────────────────
  final Color success;
  final Color error;
  final Color warning;
  final Color info;

  // ── Section Accents (for per-feature theming) ──────────────────────────────
  final Color teal; // AI Matching
  final Color indigo; // Collaboration / Chat
  final Color amber; // Projects & Tasks
  final Color burgundy; // Growth & Rewards
  final Color gold; // Achievements / badges

  const AppColorScheme({
    required this.primary,
    required this.primaryLight,
    required this.secondary,
    required this.accent,
    required this.scaffoldBg,
    required this.background,
    required this.surface,
    required this.divider,
    required this.textPrimary,
    required this.textSecondary,
    required this.textHint,
    required this.ongoingBg,
    required this.ongoingText,
    required this.completedBg,
    required this.completedText,
    required this.success,
    required this.error,
    required this.warning,
    required this.info,
    required this.teal,
    required this.indigo,
    required this.amber,
    required this.burgundy,
    required this.gold,
  });

  // ── Light Theme ────────────────────────────────────────────────────────────
  static const AppColorScheme light = AppColorScheme(
    primary: AppColors.primaryBlue,
    primaryLight: AppColors.lightBlue,
    secondary: AppColors.deepBlue,
    accent: AppColors.burgundy,

    scaffoldBg: AppColors.veryLight,
    background: AppColors.veryLight,
    surface: AppColors.white,
    divider: AppColors.lightGray,

    textPrimary: AppColors.navyBlue,
    textSecondary: AppColors.gray,
    textHint: AppColors.lightGray,

    ongoingBg: AppColors.lightBlue,
    ongoingText: AppColors.deepBlue,
    completedBg: Color(0xFFD1FAE5), // emerald-100
    completedText: Color(0xFF065F46), // emerald-800

    success: AppColors.success,
    error: AppColors.error,
    warning: AppColors.warning,
    info: AppColors.info,

    teal: AppColors.teal,
    indigo: AppColors.indigo,
    amber: AppColors.amber,
    burgundy: AppColors.burgundy,
    gold: AppColors.gold,
  );

  // ── Dark Theme ─────────────────────────────────────────────────────────────
  static const AppColorScheme dark = AppColorScheme(
    primary: AppColors.primaryBlue,
    primaryLight: Color(0xFF1E3A8A), // blue-900 tint
    secondary: AppColors.deepBlue,
    accent: AppColors.softBurgundy,

    scaffoldBg: AppColors.navyBlue,
    background: AppColors.black,
    surface: AppColors.darkGray,
    divider: Color(0xFF374151), // gray-700

    textPrimary: AppColors.white,
    textSecondary: AppColors.lightGray,
    textHint: AppColors.gray,

    ongoingBg: Color(0xFF1E3A5F), // deep navy tint
    ongoingText: Color(0xFF93C5FD), // blue-300
    completedBg: Color(0xFF064E3B), // emerald-900
    completedText: Color(0xFF34D399), // emerald-400

    success: Color(0xFF059669),
    error: Color(0xFFDC2626),
    warning: AppColors.amber,
    info: Color(0xFF60A5FA), // blue-400

    teal: AppColors.teal,
    indigo: AppColors.indigo,
    amber: AppColors.amber,
    burgundy: AppColors.softBurgundy,
    gold: AppColors.gold,
  );

  // ── Gradients ──────────────────────────────────────────────────────────────
  static const LinearGradient gradient = AppColors.buttonGradient;
  static const LinearGradient onboarding = AppColors.onboardingGradient;
  static const LinearGradient matching = AppColors.matchingGradient;
  static const LinearGradient collaboration = AppColors.collaborationGradient;
  static const LinearGradient projects = AppColors.projectsGradient;
  static const LinearGradient rewards = AppColors.rewardsGradient;
  static const LinearGradient profile = AppColors.profileGradient;

  // ── ThemeExtension overrides ───────────────────────────────────────────────
  @override
  AppColorScheme copyWith({
    Color? primary,
    Color? primaryLight,
    Color? secondary,
    Color? accent,
    Color? scaffoldBg,
    Color? background,
    Color? surface,
    Color? divider,
    Color? textPrimary,
    Color? textSecondary,
    Color? textHint,
    Color? ongoingBg,
    Color? ongoingText,
    Color? completedBg,
    Color? completedText,
    Color? success,
    Color? error,
    Color? warning,
    Color? info,
    Color? teal,
    Color? indigo,
    Color? amber,
    Color? burgundy,
    Color? gold,
  }) {
    return AppColorScheme(
      primary: primary ?? this.primary,
      primaryLight: primaryLight ?? this.primaryLight,
      secondary: secondary ?? this.secondary,
      accent: accent ?? this.accent,
      scaffoldBg: scaffoldBg ?? this.scaffoldBg,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      divider: divider ?? this.divider,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textHint: textHint ?? this.textHint,
      ongoingBg: ongoingBg ?? this.ongoingBg,
      ongoingText: ongoingText ?? this.ongoingText,
      completedBg: completedBg ?? this.completedBg,
      completedText: completedText ?? this.completedText,
      success: success ?? this.success,
      error: error ?? this.error,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      teal: teal ?? this.teal,
      indigo: indigo ?? this.indigo,
      amber: amber ?? this.amber,
      burgundy: burgundy ?? this.burgundy,
      gold: gold ?? this.gold,
    );
  }

  @override
  AppColorScheme lerp(ThemeExtension<AppColorScheme>? other, double t) {
    if (other is! AppColorScheme) return this;
    return AppColorScheme(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryLight: Color.lerp(primaryLight, other.primaryLight, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      scaffoldBg: Color.lerp(scaffoldBg, other.scaffoldBg, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textHint: Color.lerp(textHint, other.textHint, t)!,
      ongoingBg: Color.lerp(ongoingBg, other.ongoingBg, t)!,
      ongoingText: Color.lerp(ongoingText, other.ongoingText, t)!,
      completedBg: Color.lerp(completedBg, other.completedBg, t)!,
      completedText: Color.lerp(completedText, other.completedText, t)!,
      success: Color.lerp(success, other.success, t)!,
      error: Color.lerp(error, other.error, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      teal: Color.lerp(teal, other.teal, t)!,
      indigo: Color.lerp(indigo, other.indigo, t)!,
      amber: Color.lerp(amber, other.amber, t)!,
      burgundy: Color.lerp(burgundy, other.burgundy, t)!,
      gold: Color.lerp(gold, other.gold, t)!,
    );
  }
}
