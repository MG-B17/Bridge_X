import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:bridge_x/feature/projects/presentation/widgets/avatar_stack.dart';
import 'package:bridge_x/feature/projects/presentation/widgets/project_progress_bar.dart';
import 'package:bridge_x/feature/projects/presentation/widgets/project_status_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Card for an ongoing project showing status badge, title, progress bar,
/// avatar stack, and a details action link.
class OngoingProjectCard extends StatelessWidget {
  const OngoingProjectCard({
    super.key,
    required this.title,
    required this.phase,
    required this.progress,
    required this.memberCount,
    this.showYourTeamBadge = false,
    this.onDetailsTap,
  });

  final String title;
  final String phase;

  /// A value between 0.0 and 1.0.
  final double progress;
  final int memberCount;
  final bool showYourTeamBadge;
  final VoidCallback? onDetailsTap;

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
        boxShadow: AppSpacing.subtleShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Status badge row ──
          Row(
            children: [
              ProjectStatusBadge(
                label: AppStrings.ongoing,
                isCompleted: false,
              ),
              const Spacer(),
              if (showYourTeamBadge) _YourTeamBadge(),
            ],
          ),
          VerticalSpacing(AppSpacing.sm),

          // ── Title ──
          Text(
            title,
            style: AppTextStyles.headlineSmall.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          VerticalSpacing(AppSpacing.sm),

          // ── Progress bar ──
          ProjectProgressBar(
            phase: phase,
            progress: progress,
          ),
          VerticalSpacing(AppSpacing.md),

          // ── Avatar stack + details action ──
          Row(
            children: [
              AvatarStack(totalCount: memberCount),
              const Spacer(),
              GestureDetector(
                onTap: onDetailsTap,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppStrings.details,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: colors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: colors.textSecondary,
                      size: 18.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── "Your Team" badge ───────────────────────────────────────────────────────
class _YourTeamBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 5.h,
      ),
      decoration: BoxDecoration(
        color: colors.primaryLight.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
        border: Border.all(
          color: colors.primary.withValues(alpha: 0.15),
        ),
      ),
      child: Text(
        AppStrings.yourTeam,
        style: AppTextStyles.labelSmall.copyWith(
          color: colors.primary,
          fontWeight: FontWeight.w600,
          fontSize: 11.sp,
        ),
      ),
    );
  }
}
