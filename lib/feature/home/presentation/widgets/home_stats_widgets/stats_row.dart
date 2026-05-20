import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';

class StatsRow extends StatelessWidget {
  const StatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatItem(
          value: '24',
          label: AppStrings.totalTasks.toUpperCase(),
          backgroundColor: context.colors.textHint.withValues(alpha: .4),
          valueColor: context.colors.textPrimary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSpacing.radius12),
            bottomLeft: Radius.circular(AppSpacing.radius12),
          ),
        ),
        _VerticalDivider(color: context.colors.divider),
        _StatItem(
          value: '18',
          label: AppStrings.completed.toUpperCase(),
          backgroundColor: context.colors.indigo.withValues(alpha: 0.15),
          valueColor: context.colors.indigo.withValues(alpha: 0.9),
          borderRadius: BorderRadius.zero,
        ),
        _VerticalDivider(color: context.colors.divider),
        _StatItem(
          value: '04',
          label: AppStrings.projects.toUpperCase(),
          backgroundColor: context.colors.info.withValues(alpha: .3),
          valueColor: context.colors.ongoingText,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppSpacing.radius12),
            bottomRight: Radius.circular(AppSpacing.radius12),
          ),
        ),
      ],
    );
  }
}

// ── Single stat item ────────────────────────────────────────────────────────
class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.value,
    required this.label,
    required this.valueColor,
    required this.backgroundColor,
    required this.borderRadius,
  });

  final String value;
  final String label;
  final Color valueColor;
  final Color backgroundColor;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: AppSpacing.spacing8,
          horizontal: AppSpacing.spacing8,
        ),
        decoration: BoxDecoration(color: backgroundColor, borderRadius: borderRadius),
        child: Column(
          children: [
            Text(
              value,
              style: AppTextStyles.displayLarge.copyWith(
                color: valueColor,
                fontWeight: FontWeight.w800,
                fontSize: AppSpacing.fontSize26,
              ),
            ),
            VerticalSpacing(AppSpacing.height4),
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                fontSize: AppSpacing.fontSize10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Vertical divider between stats ──────────────────────────────────────────
class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: AppSpacing.height40,
      color: color.withValues(alpha: 0.4),
    );
  }
}
