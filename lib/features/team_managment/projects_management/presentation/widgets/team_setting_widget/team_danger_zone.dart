import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_names.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/feedback/error_dialog.dart';
import 'package:bridge_x/core/widget/feedback/loading_dialog.dart';
import 'package:bridge_x/core/widget/feedback/success_dialog.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_bloc.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_event.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_state.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/widgets/team_setting_widget/section_header.dart';
import 'package:bridge_x/features/team_managment/utils/project_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TeamDangerZone extends StatelessWidget {
  final int? projectId;

  const TeamDangerZone({super.key, this.projectId});

  void _confirmAndDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete team?'),
        content: const Text(
          'Are you sure you want to permanently delete this team? '
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              final pId = projectId;
              if (pId != null) {
                context.read<ProjectsFeatureBloc>().add(
                  DeleteTeamRequested(pId),
                );
              }
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectsFeatureBloc, ProjectsFeatureState>(
      listenWhen: (previous, current) =>
          previous.deleteTeam.status != current.deleteTeam.status,
      listener: (context, state) {
        if (!context.mounted) return;

        if (state.deleteTeam.status == FeatureActionStatus.loading) {
          LoadingDialog.show(context: context, message: 'Deleting team...');
        } else if (state.deleteTeam.status == FeatureActionStatus.success) {
          LoadingDialog.hide(context);
          SuccessDialog.show(
            context: context,
            title: 'Success',
            message: state.deleteTeam.message ?? '',
            onAction: () {
              context.goNamed(BridgeXRouteNames.projects);
            },
          );
          context
              .read<ProjectsFeatureBloc>()
              .add(const ClearDeleteTeamAction());
        } else if (state.deleteTeam.status == FeatureActionStatus.failure) {
          LoadingDialog.hide(context);
          ErrorDialog.show(
            context: context,
            title: 'Error',
            message: state.deleteTeam.message ?? '',
          );
          context
              .read<ProjectsFeatureBloc>()
              .add(const ClearDeleteTeamAction());
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: AppStrings.dangerZone.toUpperCase(),
              color: context.colors.error,
            ),
            VerticalSpacing(AppSpacing.spacing8),
            GestureDetector(
              onTap: () => _confirmAndDelete(context),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(AppSpacing.spacing16),
                decoration: BoxDecoration(
                  color: context.colors.error.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(AppSpacing.radius16),
                  border: Border.all(
                    color: context.colors.error.withValues(alpha: 0.3),
                    width: 1.0,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ProjectStrings.removeTeam,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: context.colors.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.delete_forever_outlined,
                      color: context.colors.error,
                      size: AppSpacing.fontSize22,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
