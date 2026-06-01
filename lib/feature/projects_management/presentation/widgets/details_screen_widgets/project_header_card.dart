import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/details/project_details_entity.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/projects_list_widgets/project_status_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectHeaderCard extends StatelessWidget {
  const ProjectHeaderCard({super.key, required this.project});

  final ProjectDetailsEntity project;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isCompleted = project.status.toLowerCase() == 'completed';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colors.onGoingColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
        border: Border.all(color: colors.divider.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52.w,
                height: 52.w,
                decoration: BoxDecoration(
                  color: colors.onGoingColor,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
                ),
                child: Icon(
                  Icons.account_balance_wallet_outlined,
                  color: colors.surface,
                  size: 26.sp,
                ),
              ),
              HorizontalSpacing(AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.headlineSmall.copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    VerticalSpacing(AppSpacing.sm),
                    ProjectStatusBadge(
                      label: project.status,
                      isCompleted: isCompleted,
                      textColor: isCompleted ? colors.completedText : colors.onGoingColor,
                      bgColor: isCompleted
                          ? colors.completedBg
                          : colors.onGoingColor.withValues(alpha: 0.35),
                    ),
                  ],
                ),
              ),
            ],
          ),
          VerticalSpacing(AppSpacing.md),
          Text(
            project.description,
            style: AppTextStyles.bodyMedium.copyWith(
              color: colors.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
