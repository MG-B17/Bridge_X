import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF003066);
  static const Color secondary = Color(0xFFDBEAFE);

  // Backgrounds
  static const Color background = Color(0xFFF8F9FD);
  static const Color card = Colors.white;

  // Text Colors
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF7A7A7A);
  static const Color hint = Color(0xFFB0B0B0);

  // Status Colors
  static const Color success = Color(0xFF059669);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFA726);

  // Borders & Divider
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFEEEEEE);

  // Buttons
  static const Color buttonPrimary = primary;
  static const Color buttonText = Colors.white;

  // Gradients
  static const LinearGradient buttonGradient = LinearGradient(
    colors: [
      Color(0xFF274C9E),
      Color(0xFF83A0E7),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkButtonGradient = LinearGradient(
    colors: [
      Color(0xFF09468C),
      Color(0xFF003066),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient chatGradient = LinearGradient(
    colors: [
      Color(0xFF274C9E),
      Color(0xFF83A0E7),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}