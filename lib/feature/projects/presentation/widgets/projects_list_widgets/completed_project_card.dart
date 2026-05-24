import 'package:bridge_x/core/utils/app_shadow.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'project_status_badge.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CompletedProjectCard extends StatelessWidget {
  const CompletedProjectCard({
    super.key,
    required this.title,
    required this.rating,
    required this.description,
    required this.actionLabel,
    required this.date,
    this.onActionTap,
  });

  final String title;
  final double rating;
  final String description;
  final String actionLabel;
  final String date;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
        border: Border.all(
          color: colors.divider.withValues(alpha: 0.3),
        ),
        boxShadow: AppShadow.subtle,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Status badge ──
          ProjectStatusBadge(
            label: AppStrings.completed,
            isCompleted: true,
            showIcon: true,
            textColor: colors.ongoingText,
            bgColor: colors.ongoingText.withValues(alpha: .4),
          ),
          VerticalSpacing(AppSpacing.sm),

          // ── Title row with star rating ──
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.headlineSmall.copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              HorizontalSpacing(AppSpacing.sm),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: colors.gold,
                    size: 18.sp,
                  ),
                  HorizontalSpacing(AppSpacing.xs),
                  Text(
                    rating.toStringAsFixed(1),
                    style: AppTextStyles.titleMedium.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          VerticalSpacing(AppSpacing.sm),

          // ── Description ──
          Text(
            description,
            style: AppTextStyles.bodyMedium.copyWith(
              color: colors.textSecondary,
              height: 1.5,
            ),
          ),
          VerticalSpacing(AppSpacing.md),

          // ── Action link + date ──
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onActionTap,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      actionLabel,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    HorizontalSpacing(AppSpacing.xs),
                    Icon(
                      Icons.arrow_forward,
                      color: colors.primary,
                      size: 16.sp,
                    ),
                  ],
                ),
              ),
              Text(
                date,
                style: AppTextStyles.labelSmall.copyWith(
                  color: colors.textHint,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

