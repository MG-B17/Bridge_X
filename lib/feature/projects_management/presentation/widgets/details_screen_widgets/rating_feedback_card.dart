import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/details/feedback_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingFeedbackCard extends StatelessWidget {
  const RatingFeedbackCard({
    super.key,
    required this.myRating,
    required this.feedbacks,
  });

  final double myRating;
  final List<FeedbackEntity> feedbacks;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final feedback = feedbacks.isNotEmpty ? feedbacks.first : null;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colors.primary.withValues(alpha: 0.08),
            colors.gold.withValues(alpha: 0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
        border: Border.all(color: colors.divider.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rating row
          Row(
            children: [
              Icon(Icons.star_rounded, color: colors.gold, size: 28.sp),
              HorizontalSpacing(AppSpacing.xs),
              Text(
                myRating.toStringAsFixed(1),
                style: AppTextStyles.displayLarge.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              HorizontalSpacing(AppSpacing.xs),
              Text(
                '/ 5',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: colors.textSecondary,
                ),
              ),
              const Spacer(),
              if (feedback != null && feedback.badge.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.spacing12,
                    vertical: AppSpacing.spacing4,
                  ),
                  decoration: BoxDecoration(
                    color: colors.gold.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
                  ),
                  child: Text(
                    feedback.badge,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: colors.gold,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
          if (feedback != null && feedback.text.isNotEmpty) ...[
            VerticalSpacing(AppSpacing.md),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
              ),
              child: Text(
                '"${feedback.text}"',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: colors.textSecondary,
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
