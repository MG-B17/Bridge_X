import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Primary Blues ──────────────────────────────────────────────────────────
  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color navyBlue = Color(0xFF0F172A);
  static const Color deepBlue = Color(0xFF1E40AF);
  static const Color lightBlue = Color(0xFFEFF6FF);

  // ── Accents ────────────────────────────────────────────────────────────────
  static const Color burgundy = Color(0xFF881E3F);
  static const Color softBurgundy = Color(0xFFB0345B);
  static const Color gold = Color(0xFFDAA337);
  static const Color teal = Color(0xFF06B6D4);
  static const Color indigo = Color(0xFF4F46E5);
  static const Color amber = Color(0xFFF59E0B);

  // ── Neutrals ───────────────────────────────────────────────────────────────
  static const Color black = Color(0xFF0B0F19);
  static const Color darkGray = Color(0xFF1F2937);
  static const Color gray = Color(0xFF6B7280);
  static const Color lightGray = Color(0xFFD1D5DB);
  static const Color veryLight = Color(0xFFF3F4F6);
  static const Color white = Color(0xFFFFFFFF);

  // ── Semantic (fixed, not theme-aware) ──────────────────────────────────────
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF2563EB);

  // ── Snackbar accent (indigo-500 — always visible on any surface) ───────────
  static const Color snackbarAccent = Color(0xFF4C6EF5);
  static const Color errorDialogBg = Color(0xFFCBDAFD);
  static const Color today = Color(0xFFE2D9FF);


  // ── Section-Specific Gradients ─────────────────────────────────────────────

  /// Dashboard / Auth — Primary Blue
  static const LinearGradient dashboardGradient = LinearGradient(
    colors: [deepBlue, primaryBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// AI Matching — Teal / Cyan
  static const LinearGradient matchingGradient = LinearGradient(
    colors: [Color(0xFF0891B2), teal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Collaboration / Chat — Indigo
  static const LinearGradient collaborationGradient = LinearGradient(
    colors: [Color(0xFF4338CA), indigo],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Projects & Tasks — Amber / Orange
  static const LinearGradient projectsGradient = LinearGradient(
    colors: [amber, Color(0xFFF97316)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Growth & Rewards — Burgundy / Gold
  static const LinearGradient rewardsGradient = LinearGradient(
    colors: [burgundy, gold],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Profile & Settings — Navy / Gray
  static const LinearGradient profileGradient = LinearGradient(
    colors: [navyBlue, darkGray],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Onboarding — Blue to Burgundy
  static const LinearGradient onboardingGradient = LinearGradient(
    colors: [primaryBlue, burgundy],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Default button gradient — Deep → Primary Blue
 static const LinearGradient buttonGradient = LinearGradient(
  colors: [
    Color(0xFF1E94DE), 
    Color(0xFF0A5FA3), 
    Color(0xFF043A78), 
  ],
  stops: [0.0, 0.45, 1.0],
  begin: Alignment.bottomRight,
  end: Alignment.topLeft,
);

  /// Dark-mode button gradient
  static const LinearGradient darkButtonGradient = LinearGradient(
    colors: [navyBlue, darkGray],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
