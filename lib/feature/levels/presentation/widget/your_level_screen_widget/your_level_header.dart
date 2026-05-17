import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/bridge_x_back_button.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';

class YourLevelHeader extends StatelessWidget {
  const YourLevelHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BridgeXBackButton(
          backgroundColor: context.colors.primary.withValues(alpha: 0.05),
          iconColor: context.colors.indigo,
          boxShadow: const [],
        ),
        VerticalSpacing(AppSpacing.md),
        Text(
          AppStrings.yourLevel,
          style: AppTextStyles.displayLarge.copyWith(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
        VerticalSpacing(AppSpacing.xs),
        Text(
          AppStrings.trackGrowth,
          style: AppTextStyles.bodyLarge.copyWith(
            color: context.colors.textSecondary,
          ),
        ),
      ],
    );
  }
}
