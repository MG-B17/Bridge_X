import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatsRow extends StatelessWidget {
  const StatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        border: Border.all(
          color: context.colors.divider.withValues(alpha: 0.5),
        ),
        boxShadow: AppSpacing.subtleShadow,
      ),
      child: Row(
        children: [
          _StatItem(
            value: '24',
            label: AppStrings.totalTasks.toUpperCase(),
            valueColor: context.colors.primary,
          ),
          _VerticalDivider(color: context.colors.divider),
          _StatItem(
            value: '18',
            label: AppStrings.completed.toUpperCase(),
            valueColor: context.colors.teal,
          ),
          _VerticalDivider(color: context.colors.divider),
          _StatItem(
            value: '04',
            label: AppStrings.projects.toUpperCase(),
            valueColor: context.colors.indigo,
          ),
        ],
      ),
    );
  }
}

// ── Single stat item ────────────────────────────────────────────────────────
class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.value,
    required this.label,
    required this.valueColor,
  });

  final String value;
  final String label;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
          SizedBox(height: 4.h),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: context.colors.textSecondary,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              fontSize: 10.sp,
            ),
          ),
        ],
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
      height: 40.h,
      color: color.withValues(alpha: 0.4),
    );
  }
}
