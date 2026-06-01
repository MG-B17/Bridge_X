import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/ongoing_project_entity.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/projects_list_widgets/avatar_stack.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/projects_list_widgets/project_progress_bar.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/projects_list_widgets/project_status_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OngoingProjectCard extends StatelessWidget {
  const OngoingProjectCard({
    super.key,
    required this.entity,
    this.onDetailsTap,
    this.onYourTeamTap,
  });

  final OngoingProjectEntity entity;
  final VoidCallback? onDetailsTap;
  final VoidCallback? onYourTeamTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colors.onGoingColor.withValues(alpha: .2),
        borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
        border: Border.all(
          color: colors.divider.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProjectStatusBadge(
            label: AppStrings.ongoing,
            isCompleted: false,
            textColor: colors.error,
            bgColor: colors.onGoingColor.withValues(alpha: .4),
          ),
          VerticalSpacing(AppSpacing.sm),

          Row(
            children: [
              Expanded(
                child: Text(
                  entity.title,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.headlineSmall.copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (entity.mySpecialization.isNotEmpty) GestureDetector(
                onTap: onYourTeamTap,
                child: _YourTeamBadge()),
            ],
          ),
          VerticalSpacing(AppSpacing.sm),

          ProjectProgressBar(
            phase: entity.category,
            progress: entity.projectCompletionPercentage / 100.0,
          ),
          VerticalSpacing(AppSpacing.md),

          Row(
            children: [
              AvatarStack(totalCount: entity.memberCount),
              const Spacer(),
              GestureDetector(
                onTap: onDetailsTap,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppStrings.details,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: colors.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    HorizontalSpacing(AppSpacing.xs),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: colors.secondary,
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
        horizontal: AppSpacing.spacing10,
        vertical: AppSpacing.spacing4,
      ),
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
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
