import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';
import '../models/onboarding_slide.dart';

class OnboardingSlideContent extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final SlideCardStyle cardStyle;

  const OnboardingSlideContent({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.cardStyle,
  });

  BoxDecoration? _getDecoration(BuildContext context) {
    switch (cardStyle) {
      case SlideCardStyle.shadow:
        return BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [context.spacing.cardShadow],
        );
      case SlideCardStyle.bordered:
        return BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: context.colors.primary.withValues(alpha: 0.2), 
            width: 1.5.w,
          ),
        );
      case SlideCardStyle.none:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration Area
          Expanded(
            flex: 3,
            child: Center(
              child: SvgPicture.asset(image),
            ),
          ),
          // Text Card
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: cardStyle == SlideCardStyle.none
                      ? EdgeInsets.symmetric(horizontal: 0, vertical: context.spacing.xxl)
                      : EdgeInsets.symmetric(horizontal: context.spacing.xl, vertical: context.spacing.xxl),
                  decoration: _getDecoration(context),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: context.displayLarge.copyWith(
                          color: context.colors.textPrimary,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      VSpace(context.spacing.md),
                      Text(
                        subtitle,
                        style: context.bodyMedium.copyWith(
                          color: context.colors.textSecondary,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
