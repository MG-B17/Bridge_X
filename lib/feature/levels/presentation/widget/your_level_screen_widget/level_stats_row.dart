import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LevelStatsRow extends StatelessWidget {
  const LevelStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            title: '128',
            subtitle: AppStrings.completedTasks,
            icon: Icons.check_circle_outline,
            backgroundColor: context.colors.textSecondary.withValues(alpha: 0.1),
            iconColor: context.colors.textPrimary,
          ),
        ),
        HorizontalSpacing(AppSpacing.md),
        Expanded(
          child: _StatCard(
            title: '4.8',
            subtitle: AppStrings.averageRating,
            icon: Icons.star_outline,
            backgroundColor: const Color(0xFFFDEBE3), // Peach background
            iconColor: const Color(0xFF8B4513), // Brown icon
            badgeText: AppStrings.top5Percent,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    this.badgeText,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final String? badgeText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        border: Border.all(
          color: context.colors.divider.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, size: 24.w, color: iconColor),
              if (badgeText != null)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8B4513), // Brown badge background
                    borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
                  ),
                  child: Text(
                    badgeText!,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: Colors.white,
                      fontSize: 8.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          VerticalSpacing(AppSpacing.sm),
          Text(
            title,
            style: AppTextStyles.headlineMedium.copyWith(
              color: context.colors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          VerticalSpacing(2.h),
          Text(
            subtitle,
            style: AppTextStyles.labelSmall.copyWith(
              color: context.colors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
