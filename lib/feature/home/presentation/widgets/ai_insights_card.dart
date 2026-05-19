import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_gradient.dart';
import 'package:bridge_x/core/utils/app_shadow.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';

class AiInsightsCard extends StatelessWidget {
  const AiInsightsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.spacing20),
      decoration: BoxDecoration(
        gradient: AppGradient.aiInsightsCard(
          primaryLight: context.colors.primaryLight,
          indigo: context.colors.indigo,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radius16),
        border: Border.all(
          color: context.colors.primary.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Title row ──
          Row(
            children: [
              Text('✨', style: TextStyle(fontSize: AppSpacing.spacing20)),
              HorizontalSpacing(AppSpacing.spacing8),
              Text(
                AppStrings.aiInsights,
                style: AppTextStyles.titleLarge.copyWith(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          VerticalSpacing(AppSpacing.spacing16),
          _InsightItem(
            icon: Icons.trending_up_rounded,
            iconColor: context.colors.teal,
            text: AppStrings.insightProductivity,
          ),
          VerticalSpacing(AppSpacing.height14),
          _InsightItem(
            icon: Icons.access_time_rounded,
            iconColor: context.colors.amber,
            text: AppStrings.insightPeakTime,
          ),
        ],
      ),
    );
  }
}

// ── Single insight row ──────────────────────────────────────────────────────
class _InsightItem extends StatelessWidget {
  const _InsightItem({
    required this.icon,
    required this.iconColor,
    required this.text,
  });

  final IconData icon;
  final Color iconColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: AppSpacing.spacing30,
          height: AppSpacing.spacing30,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.12),
            shape: BoxShape.circle,
            boxShadow: AppShadow.floating(iconColor),
          ),
          child: Icon(icon, color: iconColor, size: AppSpacing.spacing16),
        ),
        HorizontalSpacing(AppSpacing.spacing12),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodyMedium.copyWith(
              color: context.colors.textSecondary,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
