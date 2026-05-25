import 'package:bridge_x/core/animation/bottom_nav_bar_animation/controller/scroll_cubit.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_back_button.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/dashboard/project_dashboard_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProjectDashboardHeader extends StatelessWidget {
  final ProjectDashboardEntity project;

  const ProjectDashboardHeader({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VerticalSpacing(AppSpacing.spacing16),
        BridgeXBackButton(
          onTap: () {
            context.read<ScrollCubit>().show();
            context.pop();
          },
        ),
        VerticalSpacing(AppSpacing.spacing16),
        Row(
          children: [
            
              Container(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing12, vertical: AppSpacing.spacing4),
                decoration: BoxDecoration(
                  color: context.colors.secondary,
                  borderRadius: BorderRadius.circular(AppSpacing.radius16),
                ),
                child: Text(
                  AppStrings.youAreMentorBadge,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: context.colors.surface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            HorizontalSpacing(AppSpacing.spacing8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing12, vertical: AppSpacing.spacing4),
              decoration: BoxDecoration(
                color: context.colors.onGoingColor.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(AppSpacing.radius16),
              ),
              child: Text(
                project.projectStatus,
                style: AppTextStyles.labelSmall.copyWith(
                  color: context.colors.onGoingColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        VerticalSpacing(AppSpacing.spacing20),
        Text(
          project.projectTitle,
          style: AppTextStyles.headlineMedium.copyWith(
            color: context.colors.textPrimary,
          ),
        ),
        VerticalSpacing(AppSpacing.spacing12),
        Text(
          project.description,
          style: AppTextStyles.bodyMedium.copyWith(
            color: context.colors.textSecondary,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
