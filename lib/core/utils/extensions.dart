import 'package:flutter/material.dart';
import '../theme/app_color_scheme.dart';
import '../theme/text_style.dart';
import '../constant/app_spacing.dart';

extension AppColors on BuildContext {
  AppColorScheme get colors => Theme.of(this).extension<AppColorScheme>()!;
}

extension AppTypography on BuildContext {
  TextStyle get displayLarge => AppTextStyles.displayLarge;
  TextStyle get headlineMedium => AppTextStyles.headlineMedium;
  TextStyle get titleLarge => AppTextStyles.titleLarge;
  TextStyle get bodyLarge => AppTextStyles.bodyLarge;
  TextStyle get bodyMedium => AppTextStyles.bodyMedium;
  TextStyle get labelSmall => AppTextStyles.labelSmall;
}

class SpacingProxy {
  double get xs => AppSpacing.xs;
  double get sm => AppSpacing.sm;
  double get md => AppSpacing.md;
  double get lg => AppSpacing.lg;
  double get xl => AppSpacing.xl;
  double get xxl => AppSpacing.xxl;
  double get radiusCard => AppSpacing.radiusCard;
  double get radiusCardLarge => AppSpacing.radiusCardLarge;
  double get radiusPill => AppSpacing.radiusPill;
  BoxShadow get cardShadow => AppSpacing.cardShadow;
}

extension AppSpacingExt on BuildContext {
  SpacingProxy get spacing => SpacingProxy();
}
