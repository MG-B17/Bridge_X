import 'package:flutter/material.dart';
import 'package:bridgex/core/theme/app_color_scheme.dart';

extension BuildContextExtension on BuildContext {
  // Theme Extensions
  AppColorScheme get colors => Theme.of(this).extension<AppColorScheme>()!;

  // Typography Extensions (read from active ThemeData)
  TextStyle get displayLarge => Theme.of(this).textTheme.displayLarge!;
  TextStyle get headlineMedium => Theme.of(this).textTheme.headlineMedium!;
  TextStyle get titleLarge => Theme.of(this).textTheme.titleLarge!;
  TextStyle get bodyLarge => Theme.of(this).textTheme.bodyLarge!;
  TextStyle get bodyMedium => Theme.of(this).textTheme.bodyMedium!;
  TextStyle get labelSmall => Theme.of(this).textTheme.labelSmall!;

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
