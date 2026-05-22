import 'package:bridge_x/core/theme/bridge_x_colors.dart';
import 'package:flutter/material.dart';

abstract class AppGradient {
  static const LinearGradient button = AppColors.buttonGradient;
  static const LinearGradient dashboard = AppColors.dashboardGradient;
  static const LinearGradient onboarding = AppColors.onboardingGradient;
  static const LinearGradient matching = AppColors.matchingGradient;
  static const LinearGradient collaboration = AppColors.collaborationGradient;
  static const LinearGradient projects = AppColors.projectsGradient;
  static const LinearGradient rewards = AppColors.rewardsGradient;
  static const LinearGradient profile = AppColors.profileGradient;

  static LinearGradient productivityCard({required Color primaryLight, required Color teal}) => LinearGradient(
        begin: Alignment.center,
        end: Alignment(1,-1),
        colors: [primaryLight.withValues(alpha: 0.35), teal.withValues(alpha: 0.2)],
      );

  static const LinearGradient projectBarsCard = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.cardBgStart, AppColors.cardBgMid, AppColors.cardBgEnd],
    stops: [0.0, 0.6, 1.0],
  );

  static const LinearGradient barFill = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [AppColors.barGradientBottom, AppColors.barGradientMid, AppColors.barGradientTop],
  );

  static LinearGradient productivityCardFull({required Color surface}) => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [surface, AppColors.cardSurfaceMid, AppColors.cardSurfaceEnd],
    stops: const [0.0, 0.65, 1.0],
  );

  static LinearGradient aiInsightsCard({required Color primaryLight, required Color indigo}) =>
      LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [primaryLight.withValues(alpha: 0.35), indigo.withValues(alpha: 0.08)],
      );

  static LinearGradient tinted({
    required Color from,
    required Color to,
    double fromAlpha = 1.0,
    double toAlpha = 1.0,
    Alignment begin = Alignment.topLeft,
    Alignment end = Alignment.bottomRight,
  }) => LinearGradient(
    begin: begin,
    end: end,
    colors: [
      from.withValues(alpha: fromAlpha),
      to.withValues(alpha: toAlpha),
    ],
  );
}
