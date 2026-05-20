import 'package:bridge_x/core/theme/bridge_x_colors.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:flutter/material.dart';

abstract class AppShadow {
  static List<BoxShadow> get card => [
    BoxShadow(
      color: AppColors.shadowDark,
      blurRadius: AppSpacing.radius16,
      spreadRadius: AppSpacing.radius2,
      offset: Offset(0, AppSpacing.height8),
    ),
  ];

  static List<BoxShadow> get subtle => [
    BoxShadow(
      color: AppColors.shadowSubtle,
      blurRadius: AppSpacing.radius8,
      offset: Offset(0, AppSpacing.height4),
    ),
  ];

  static List<BoxShadow> floating(Color accentColor) => [
    BoxShadow(
      color: accentColor.withValues(alpha: 0.08),
      blurRadius: AppSpacing.radius12,
      offset: Offset(0, AppSpacing.height4),
    ),
  ];

  static List<BoxShadow> get chartCard => [
    BoxShadow(
      color: AppColors.shadowLight,
      blurRadius: AppSpacing.radius18,
      offset: Offset(0, AppSpacing.height6),
    ),
    BoxShadow(
      color: AppColors.glowBlue.withValues(alpha: 0.10),
      blurRadius: AppSpacing.radius24,
      offset: Offset(0, AppSpacing.height10),
    ),
  ];

  static List<BoxShadow> get projectBarsCard => [
    BoxShadow(
      color: AppColors.glowBlue.withValues(alpha: 0.10),
      blurRadius: AppSpacing.radius30,
      offset: Offset(0, AppSpacing.height10),
    ),
  ];

  static List<BoxShadow> get barGlow => [
    BoxShadow(
      color: AppColors.barGlow,
      blurRadius: AppSpacing.radius10,
      spreadRadius: -AppSpacing.radius2,
    ),
  ];

  static List<BoxShadow> particleGlow(Color color) => [
    BoxShadow(color: color.withValues(alpha: 0.40), blurRadius: AppSpacing.radius10),
  ];

  static List<BoxShadow> glow(Color color) => [
    BoxShadow(
      color: color.withValues(alpha: 0.20),
      blurRadius: AppSpacing.radius24,
      spreadRadius: AppSpacing.radius2,
    ),
  ];

  static List<BoxShadow> snackBar(Color accentColor) => [
    BoxShadow(
      color: AppColors.shadowStrong,
      blurRadius: AppSpacing.radius24,
      spreadRadius: AppSpacing.radius2,
      offset: Offset(0, AppSpacing.height8),
    ),
    BoxShadow(
      color: accentColor.withValues(alpha: 0.10),
      blurRadius: AppSpacing.radius12,
      offset: Offset(0, AppSpacing.height3),
    ),
  ];

  static List<BoxShadow> bottomNavBar(Color color) => [
        BoxShadow(
          color: color,
          blurRadius: AppSpacing.radius20,
          spreadRadius: AppSpacing.radius2,
          offset: Offset(0, -AppSpacing.height4),
        ),
      ];
}
