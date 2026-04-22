import 'package:flutter/material.dart';
import 'package:bridgex/core/theme/app_color_scheme.dart';
import 'package:bridgex/core/theme/text_style.dart';

extension BuildContextExtension on BuildContext {
  // Theme Extensions
  AppColorScheme get colors => Theme.of(this).extension<AppColorScheme>()!;

  // Typography Extensions (mapping directly to AppTextStyles for ease of use)
  TextStyle get displayLarge => AppTextStyles.displayLarge;
  TextStyle get headlineMedium => AppTextStyles.headlineMedium;
  TextStyle get titleLarge => AppTextStyles.titleLarge;
  TextStyle get bodyLarge => AppTextStyles.bodyLarge;
  TextStyle get bodyMedium => AppTextStyles.bodyMedium;
  TextStyle get labelSmall => AppTextStyles.labelSmall;

  // Screen Utilities
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  // SnackBar Utility
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: bodyMedium.copyWith(color: colors.surface),
        ),
        backgroundColor: isError ? Colors.red : colors.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

extension StringExtension on String {
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}
