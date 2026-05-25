import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LevelRoadmapSection extends StatelessWidget {
  const LevelRoadmapSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Row
        Row(
          children: [
            Icon(Icons.map_outlined, color: context.colors.textPrimary, size: 24.w),
            HorizontalSpacing(AppSpacing.sm),
            Text(
              AppStrings.levelRoadmap,
              style: AppTextStyles.titleMedium.copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        VerticalSpacing(AppSpacing.lg),
        
        // Roadmap Steps
        _RoadmapStep(
          title: AppStrings.beginnerTier,
          isActiveTier: true,
          isCompleted: true,
          isLast: false,
          child: Row(
            children: [
              _TierBadge(label: AppStrings.bronze, status: _BadgeStatus.completed),
              HorizontalSpacing(AppSpacing.sm),
              _TierBadge(label: AppStrings.silver, status: _BadgeStatus.active),
              HorizontalSpacing(AppSpacing.sm),
              _TierBadge(label: AppStrings.gold, status: _BadgeStatus.dashed),
            ],
          ),
        ),
        
        _RoadmapStep(
          title: AppStrings.juniorTier,
          isActiveTier: false,
          isCompleted: false,
          isLast: false,
          child: Row(
            children: [
              _TierBadge(label: AppStrings.bronze, status: _BadgeStatus.locked),
              HorizontalSpacing(AppSpacing.sm),
              _TierBadge(label: AppStrings.silver, status: _BadgeStatus.locked),
              HorizontalSpacing(AppSpacing.sm),
              _TierBadge(label: AppStrings.gold, status: _BadgeStatus.locked),
            ],
          ),
        ),

        _RoadmapStep(
          title: AppStrings.seniorTier,
          isActiveTier: false,
          isCompleted: false,
          isLast: true,
          child: Row(
            children: [
              _TierBadge(label: AppStrings.bronze, status: _BadgeStatus.locked),
            ],
          ),
        ),
      ],
    );
  }
}

class _RoadmapStep extends StatelessWidget {
  const _RoadmapStep({
    required this.title,
    required this.isActiveTier,
    required this.isCompleted,
    required this.isLast,
    required this.child,
  });

  final String title;
  final bool isActiveTier;
  final bool isCompleted;
  final bool isLast;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Node & Line column
          Column(
            children: [
              // Node circle
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActiveTier 
                      ? context.colors.primaryLight.withValues(alpha: 0.3) 
                      : context.colors.divider.withValues(alpha: 0.2),
                ),
                child: Center(
                  child: Container(
                    width: 16.w,
                    height: 16.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActiveTier 
                          ? const Color(0xFF0D3269) // Dark blue
                          : context.colors.divider.withValues(alpha: 0.5),
                    ),
                    child: isActiveTier
                        ? Icon(Icons.check, size: 10.w, color: Colors.white)
                        : null,
                  ),
                ),
              ),
              // Line
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2.w,
                    color: context.colors.divider.withValues(alpha: 0.5),
                  ),
                ),
            ],
          ),
          HorizontalSpacing(AppSpacing.md),
          // Content column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalSpacing(2.h),
                Text(
                  title,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: isActiveTier 
                        ? const Color(0xFF0D3269) 
                        : context.colors.textSecondary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                VerticalSpacing(AppSpacing.sm),
                child,
                VerticalSpacing(AppSpacing.xl), // Spacing to next node
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum _BadgeStatus { completed, active, dashed, locked }

class _TierBadge extends StatelessWidget {
  const _TierBadge({
    required this.label,
    required this.status,
  });

  final String label;
  final _BadgeStatus status;

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    Border? border;

    switch (status) {
      case _BadgeStatus.completed:
        bgColor = context.colors.divider.withValues(alpha: 0.3);
        textColor = context.colors.textPrimary;
        break;
      case _BadgeStatus.active:
        bgColor = const Color(0xFF0D3269); // Dark blue
        textColor = Colors.white;
        break;
      case _BadgeStatus.dashed:
        bgColor = Colors.transparent;
        textColor = context.colors.textHint;
        border = Border.all(color: context.colors.divider, width: 1, style: BorderStyle.solid);
        break;
      case _BadgeStatus.locked:
        bgColor = context.colors.divider.withValues(alpha: 0.1);
        textColor = context.colors.textHint;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        border: border,
      ),
      child: Text(
        label,
        style: AppTextStyles.titleMedium.copyWith(
          color: textColor,
          fontWeight: status == _BadgeStatus.active ? FontWeight.bold : FontWeight.w600,
        ),
      ),
    );
  }
}
