import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/onboarding/presentation/model/onboarding_content_model.dart';
import 'package:bridge_x/feature/onboarding/presentation/widgets/onboarding_smooth_page_indecator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key, required this.content});

  final OnboardingContentModel content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: 300.h,
            child: SvgPicture.asset(content.image),
          ),
          VerticalSpacing(16),
          Text(
            content.title,
            style: context.textTheme.headlineMedium?.copyWith(
              color: context.colors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          VerticalSpacing(10.h),
          Text(
            content.description,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colors.textSecondary,
            ),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          VerticalSpacing(20.h),
          OnboardingSmoothPageIndicator()
        ],
      ),
    );
  }
}
