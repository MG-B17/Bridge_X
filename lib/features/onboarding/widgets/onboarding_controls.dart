import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/bridge_app_button.dart';
import '../../../core/widgets/v_space.dart';

class OnboardingControls extends StatelessWidget {
  final PageController pageController;
  final int totalSlides;
  final int currentIndex;
  final VoidCallback onNext;

  const OnboardingControls({
    super.key,
    required this.pageController,
    required this.totalSlides,
    required this.currentIndex,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SmoothPageIndicator(
            controller: pageController,
            count: totalSlides,
            effect: ExpandingDotsEffect(
              activeDotColor: context.colors.primary,
              dotColor: context.colors.textHint.withValues(alpha: 0.3),
              dotHeight: 8.h,
              dotWidth: 6.h,
              spacing: context.spacing.sm,
            ),
          ),
          VSpace(context.spacing.xxl),
          AppButton(
            label: currentIndex == totalSlides - 1 ? 'Get Started' : 'Next',
            onPressed: onNext,
            trailing: currentIndex != totalSlides - 1 
                ? Icon(Icons.arrow_forward, color: Colors.white, size: context.spacing.lg)
                : null,
          ),
          VSpace(context.spacing.xxl),
        ],
      ),
    );
  }
}
