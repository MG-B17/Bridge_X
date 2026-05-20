import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';

class NoTeamsTitle extends StatelessWidget {
  const NoTeamsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      children: [
        Text(
          AppStrings.noTeamsFound,
          style: AppTextStyles.displayLarge.copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
        VerticalSpacing(AppSpacing.spacing8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing16),
          child: Text(
            AppStrings.noTeamsFoundSubtitle,
            style: AppTextStyles.bodyMedium.copyWith(
              color: colors.textSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
