import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_bloc.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_event.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/widgets/team_setting_widget/section_header.dart';
import 'package:bridge_x/features/skills_and_experience/presentation/widget/skills_and_experience_widget/dashed_border_painter.dart';
import 'package:bridge_x/features/team_managment/utils/project_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeamProjectControl extends StatelessWidget {
  final int? projectId;

  const TeamProjectControl({super.key, this.projectId});

  void _onSubmitTap(BuildContext context) {
    final id = projectId;
    if (id == null) return;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(ProjectStrings.submitProjectAsCompleted),
        content: const Text(ProjectStrings.projectCompletionConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context
                  .read<ProjectsFeatureBloc>()
                  .add(SubmitProjectConfirmed(id));
            },
            child: const Text(AppStrings.confirm),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: ProjectStrings.projectControl.toUpperCase()),
        VerticalSpacing(AppSpacing.spacing8),
        CustomPaint(
          painter: DashedBorderPainter(
            color: context.colors.primary.withValues(alpha: 0.3),
            borderRadius: AppSpacing.radius16,
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppSpacing.spacing20),
            decoration: BoxDecoration(
              color: context.colors.primaryLight.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(AppSpacing.radius16),
            ),
            child: Column(
              children: [
                Text(
                  ProjectStrings.projectCompletionConfirmation,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.textPrimary,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                VerticalSpacing(AppSpacing.spacing16),
                GestureDetector(
                  onTap: () => _onSubmitTap(context),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: AppSpacing.spacing12,
                    ),
                    decoration: BoxDecoration(
                      color: context.colors.primaryLight,
                      borderRadius: BorderRadius.circular(AppSpacing.radius12),
                      border: Border.all(
                        color: context.colors.primary.withValues(alpha: 0.2),
                        width: 1.0,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        ProjectStrings.submitProjectAsCompleted,
                        style: context.textTheme.titleMedium?.copyWith(
                          color: context.colors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
