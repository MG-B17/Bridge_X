import 'package:bridge_x/core/utils/app_shadow.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:bridge_x/feature/projects/presentation/widgets/projects_list_widgets/avatar_stack.dart';
import 'package:bridge_x/feature/projects/presentation/widgets/projects_list_widgets/project_progress_bar.dart';
import 'package:bridge_x/feature/projects/presentation/widgets/projects_list_widgets/project_status_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


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
        boxShadow: AppShadow.subtle,
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
                    HorizontalSpacing(AppSpacing.xs),
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

