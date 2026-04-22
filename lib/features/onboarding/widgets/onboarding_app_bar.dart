import 'package:flutter/material.dart';
import '../../../core/constant/app_strings.dart';
import '../../../core/utils/extensions.dart';

class OnboardingAppBar extends StatelessWidget {
  final VoidCallback onSkip;

  const OnboardingAppBar({super.key, required this.onSkip});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.spacing.xl, vertical: context.spacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppStrings.appName,
            style: context.headlineMedium.copyWith(
              color: context.colors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: onSkip,
            style: TextButton.styleFrom(
              foregroundColor: context.colors.textSecondary,
            ),
            child: Text(
              'Skip',
              style: context.bodyMedium.copyWith(
                color: context.colors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
