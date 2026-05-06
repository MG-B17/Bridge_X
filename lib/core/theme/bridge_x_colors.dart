import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // Prevent instantiation

  // ── Brand Palette ──────────────────────────────────────────────────────────
  static const Color brandNavy = Color(0xFF003066);
  static const Color brandBlue = Color(0xFF4A6CF7);
  static const Color brandLightBlue = Color(0xFF83A0E7);
  static const Color brandDeepBlue = Color(0xFF274C9E);

  // ── Semantic (fixed, not theme-aware) ──────────────────────────────────────
  static const Color success = Color(0xFF059669);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFA726);

  // ── Gradients ──────────────────────────────────────────────────────────────
  static const LinearGradient buttonGradient = LinearGradient(
    colors: [Color(0xFF274C9E), Color(0xFF83A0E7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkButtonGradient = LinearGradient(
    colors: [Color(0xFF09468C), Color(0xFF003066)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient chatGradient = LinearGradient(
    colors: [Color(0xFF274C9E), Color(0xFF83A0E7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}