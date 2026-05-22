import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileStats extends StatelessWidget {
  const ProfileStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatCard(
          value: '12',
          label: 'COMPLETED\nTASKS',
        ),
        HorizontalSpacing(AppSpacing.sm),
        _StatCard(
          value: '3',
          label: 'TEAMS',
        ),
        HorizontalSpacing(AppSpacing.sm),
        _StatCard(
          value: '10',
          label: 'ACTIVE TASKS',
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
  });

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: AppSpacing.lg),
        decoration: BoxDecoration(
          color: context.colors.primary.withValues(alpha: 0.05), // Light background
          borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
          border: Border.all(
            color: context.colors.divider.withValues(alpha: 0.3),
            width: 1.w,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: AppTextStyles.headlineMedium.copyWith(
                color: context.colors.textPrimary, // Value color
                fontWeight: FontWeight.w800, // Extra bold
              ),
            ),
            VerticalSpacing(4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyles.labelSmall.copyWith(
                color: context.colors.textSecondary, // Label color
                fontSize: 9.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

