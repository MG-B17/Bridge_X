import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            topLeft: Radius.circular(AppSpacing.radiusCard),
            bottomLeft: Radius.circular(AppSpacing.radiusCard),
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
            topRight: Radius.circular(AppSpacing.radiusCard),
            bottomRight: Radius.circular(AppSpacing.radiusCard),
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
        padding: EdgeInsets.symmetric(vertical: AppSpacing.sm, horizontal: AppSpacing.sm),
        decoration: BoxDecoration(color: backgroundColor, borderRadius: borderRadius),
        child: Column(
          children: [
            Text(
              value,
              style: AppTextStyles.displayLarge.copyWith(
                color: valueColor,
                fontWeight: FontWeight.w800,
                fontSize: 26.sp,
              ),
            ),
            VerticalSpacing(4.h),
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                fontSize: 10.sp,
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
    return Container(width: 1, height: 40.h, color: color.withValues(alpha: 0.4));
  }
}
