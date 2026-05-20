import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';

class DynamicInsightCard extends StatelessWidget {
  const DynamicInsightCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.spacing16),
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(AppSpacing.radius20),
        border: Border.all(color: context.colors.primary.withValues(alpha: .5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: AppSpacing.spacing36,
            height: AppSpacing.spacing36,
            decoration: BoxDecoration(
              color: colors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppSpacing.radius6),
            ),
            child: Icon(
              Icons.psychology_rounded,
              color: colors.primary,
              size: AppSpacing.fontSize20,
            ),
          ),
          HorizontalSpacing(AppSpacing.spacing16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.dynamicInsight.toUpperCase(),
                  style: AppTextStyles.labelSmall.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    fontSize: AppSpacing.fontSize11,
                  ),
                ),
                VerticalSpacing(AppSpacing.spacing4),
                Text(
                  AppStrings.dynamicInsightSubtitle,
                  style: AppTextStyles.bodyMedium.copyWith(color: colors.textPrimary, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
