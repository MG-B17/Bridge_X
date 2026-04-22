import 'package:flutter/material.dart';
import '../theme/app_color_scheme.dart';
import '../theme/text_style.dart';

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
