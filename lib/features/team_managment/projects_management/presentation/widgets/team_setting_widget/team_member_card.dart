import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_names.dart';
import 'package:bridge_x/core/navigation/screens_args/report_user_args.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/feedback/error_dialog.dart';
import 'package:bridge_x/core/widget/feedback/loading_dialog.dart';
import 'package:bridge_x/core/widget/feedback/success_dialog.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/dashboard/team_member_entity.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_bloc.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_event.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_state.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/widgets/team_setting_widget/avatar_utils.dart';
import 'package:bridge_x/features/team_managment/utils/project_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TeamMemberCard extends StatelessWidget {
  final TeamMemberEntity member;
  final int? projectId;

  const TeamMemberCard({
    super.key,
    required this.member,
    this.projectId,
  });

  void _handleMenuAction(BuildContext context, String value) {
    if (value == 'report_user') {
      context.pushNamed(
        BridgeXRouteNames.reportUser,
        extra: ReportUserArgs(userId: member.programmerId),
      );
    } else if (value == 'make_mentor') {
      _confirmAndChangeLeader(context);
    }
  }

  void _confirmAndChangeLeader(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Transfer leadership?'),
        content: Text(
          'Are you sure you want to make ${member.name} the team leader? '
          'Team settings is only available to the current leader. '
          'If you transfer leadership, you will be taken back to Projects '
          'and you will no longer be able to access this project\'s settings.',
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
                  ChangeLeaderRequested(pId, member.programmerId),
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
          previous.changeLeader.status != current.changeLeader.status,
      listener: (context, state) {
        if (!context.mounted) return;

        if (state.changeLeader.status == FeatureActionStatus.loading) {
          LoadingDialog.show(
            context: context,
            message: 'Transferring leadership...',
          );
        } else if (state.changeLeader.status == FeatureActionStatus.success) {
          LoadingDialog.hide(context);
          SuccessDialog.show(
            context: context,
            title: 'Success',
            message: state.changeLeader.message ?? '',
            onAction: () {
              context.goNamed(BridgeXRouteNames.projects);
            },
          );
          context
              .read<ProjectsFeatureBloc>()
              .add(const ClearChangeLeaderAction());
        } else if (state.changeLeader.status == FeatureActionStatus.failure) {
          LoadingDialog.hide(context);
          ErrorDialog.show(
            context: context,
            title: 'Error',
            message: state.changeLeader.message ?? '',
          );
          context
              .read<ProjectsFeatureBloc>()
              .add(const ClearChangeLeaderAction());
        }
      },
      builder: (context, state) {
          return Container(
            margin: EdgeInsets.only(bottom: AppSpacing.spacing12),
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.spacing16,
              vertical: AppSpacing.spacing12,
            ),
            decoration: BoxDecoration(
              color: context.colors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radius16),
              border: Border.all(
                color: context.colors.primaryLight,
                width: 1.0,
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: AppSpacing.radius20,
                  backgroundColor: AvatarUtils.background(member.programmerId),
                  child: Text(
                    AvatarUtils.initials(member.name),
                    style: context.textTheme.titleMedium?.copyWith(
                      color: AvatarUtils.text(member.programmerId),
                      fontWeight: FontWeight.bold,
                      fontSize: AppSpacing.fontSize14,
                    ),
                  ),
                ),
                HorizontalSpacing(AppSpacing.spacing12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        member.name,
                        style: context.textTheme.titleMedium?.copyWith(
                          color: context.colors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        member.track,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: context.colors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  icon: Icon(
                    Icons.more_vert,
                    color: context.colors.textSecondary,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radius16),
                  ),
                  color: context.colors.surface,
                  elevation: 4,
                  onSelected: (value) => _handleMenuAction(context, value),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'assign_task',
                      child: Row(
                        children: [
                          Icon(Icons.assignment_outlined, size: 20, color: context.colors.textPrimary),
                          HorizontalSpacing(AppSpacing.spacing12),
                          Text(ProjectStrings.assignTask, style: context.textTheme.bodyMedium?.copyWith(color: context.colors.textPrimary)),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'make_mentor',
                      child: Row(
                        children: [
                          Icon(Icons.school_outlined, size: 20, color: context.colors.textPrimary),
                          HorizontalSpacing(AppSpacing.spacing12),
                          Text(ProjectStrings.makeMentor, style: context.textTheme.bodyMedium?.copyWith(color: context.colors.textPrimary)),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'report_user',
                      child: Row(
                        children: [
                          Icon(Icons.error_outline, size: 20, color: context.colors.error),
                          HorizontalSpacing(AppSpacing.spacing12),
                          Text(ProjectStrings.reportUser, style: context.textTheme.bodyMedium?.copyWith(color: context.colors.error)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
    );
  }
}
