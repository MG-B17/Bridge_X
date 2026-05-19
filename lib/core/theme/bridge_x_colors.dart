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

  // ── Home / Chart card palette ──────────────────────────────────────────────
  static const Color cardSurfaceMid    = Color(0xFFF7FBFF);
  static const Color cardSurfaceEnd    = Color(0xFFEAF6FF);
  static const Color cardBorderTint    = Color(0xFFC3D6E2);
  static const Color glowBlue          = Color(0xFF80BBFF);

  // ── Bar chart gradient ─────────────────────────────────────────────────────
  static const Color barGradientBottom = Color(0xFF5B2392);
  static const Color barGradientMid    = Color(0xFF133E87);
  static const Color barGradientTop    = Color(0xFF3BC7E8);
  static const Color barGlow           = Color(0xFF3BC7E8);
  static const Color barTrack          = Color(0xFFD9D9DD);

  // ── Project bars card palette ──────────────────────────────────────────────
  static const Color cardBgStart       = Color(0xFFF8FBFF);
  static const Color cardBgMid         = Color(0xFFF4FAFF);
  static const Color cardBgEnd         = Color(0xFFEFF8FF);
  static const Color cardBorderBlue    = Color(0xFF8BAFFF);
  static const Color particleCyan      = Color(0xFF9CEBFF);

  static const Color shadowDark        = Color(0x1F000000);
  static const Color shadowSubtle      = Color(0x0F000000);
  static const Color shadowStrong      = Color(0x2E000000);
  static const Color shadowLight       = Color(0x0A000000);


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
