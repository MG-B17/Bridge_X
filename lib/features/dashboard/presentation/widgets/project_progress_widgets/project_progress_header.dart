import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';

class ProjectProgressHeader extends StatelessWidget {
  const ProjectProgressHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.projectProgress,
          style: AppTextStyles.displayLarge.copyWith(
            color: context.colors.textPrimary,
            fontSize: AppSpacing.fontSize26,
            fontWeight: FontWeight.bold,
          ),
        ),
        VerticalSpacing(AppSpacing.spacing6),
        Text(
          AppStrings.projectProgressSubtitle,
          style: AppTextStyles.bodyMedium.copyWith(
            color: context.colors.textSecondary,
            fontSize: AppSpacing.fontSize15,
          ),
        ),
      ],
    );
  }
}
