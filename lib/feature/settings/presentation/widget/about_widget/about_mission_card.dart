import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';

class AboutMissionCard extends StatelessWidget {
  const AboutMissionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.spacing24),
      decoration: BoxDecoration(
        color: context.colors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppSpacing.radius16),
        border: Border.all(color: context.colors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.rocket_launch_outlined,
            color: context.colors.ongoingText,
            size: AppSpacing.spacing32,
          ),
          VerticalSpacing(AppSpacing.spacing16),
          Text(
            AppStrings.ourMission,
            style: AppTextStyles.titleMedium.copyWith(
              color: context.colors.textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
          VerticalSpacing(AppSpacing.spacing4),
          Text(
            AppStrings.ourMissionDesc,
            style: AppTextStyles.bodyMedium.copyWith(
              color: context.colors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
