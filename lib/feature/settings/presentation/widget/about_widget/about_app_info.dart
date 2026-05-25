import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';

class AboutAppInfo extends StatelessWidget {
  const AboutAppInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.appName,
          style: AppTextStyles.displayLarge.copyWith(
            fontSize: AppSpacing.fontSize30,
            color: context.colors.ongoingText,
            fontWeight: FontWeight.w900,
          ),
          textAlign: TextAlign.center,
        ),
        VerticalSpacing(AppSpacing.spacing8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing24),
          child: Text(
            AppStrings.aboutBridgeXDesc,
            style: AppTextStyles.bodyLarge.copyWith(
              color: context.colors.textSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        VerticalSpacing(AppSpacing.spacing24),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.spacing20,
            vertical: AppSpacing.spacing8,
          ),
          decoration: BoxDecoration(
            color: context.colors.ongoingText.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(AppSpacing.radius32),
          ),
          child: Text(
            AppStrings.version,
            style: AppTextStyles.labelSmall.copyWith(
              color: context.colors.ongoingText,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }
}
