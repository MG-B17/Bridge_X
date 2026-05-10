import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/feature/onboarding/presentation/controller/onboarding_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingSmoothPageIndicator extends StatelessWidget {
  const OnboardingSmoothPageIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Consumer<OnboardingProvider>(
      builder: (context, provider, _) => SmoothPageIndicator(
        controller: provider.pageController,
        count: provider.onboardingContents.length,
        effect: ExpandingDotsEffect(
          activeDotColor: colors.primary,
          dotColor: colors.primary.withValues(alpha: 0.35),
          dotHeight: 8.h,
          dotWidth: 8.w,
          expansionFactor: 3.5,
          spacing: 6.w,
        ),
      ),
    );
  }
}
