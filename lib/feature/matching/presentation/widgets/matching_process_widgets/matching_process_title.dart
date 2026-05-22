import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';

class MatchingProcessTitle extends StatelessWidget {
  const MatchingProcessTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      children: [
        Text(
          AppStrings.matchingTitle,
          style: AppTextStyles.displayLarge.copyWith(
            color: colors.secondary,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
        VerticalSpacing(AppSpacing.spacing8),
        Text(
          AppStrings.matchingSubtitleFull,
          style: AppTextStyles.bodyMedium.copyWith(
            color: colors.textPrimary,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
