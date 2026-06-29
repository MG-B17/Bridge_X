import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/init/app_state.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_names.dart';
import 'package:bridge_x/core/navigation/screens_args/view_task_args.dart';
import 'package:bridge_x/core/services/logger_service.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_bloc.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_event.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_state.dart';
import 'package:bridge_x/features/team_managment/utils/project_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProjectDetailsActionButtons extends StatelessWidget {
  const ProjectDetailsActionButtons({super.key, required this.projectId, this.teamId});

  final int projectId;
  final int? teamId;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            label: ProjectStrings.viewTasks,
            icon: Icons.assignment_outlined,
            backgroundColor: colors.secondary,
            foregroundColor: colors.surface,
            onTap: () => context.pushNamed(
              BridgeXRouteNames.viewTask,
              extra: ViewTaskArgs(projectId: projectId),
            ),
          ),
        ),
        HorizontalSpacing(AppSpacing.spacing8),
        Expanded(
          child: _ActionButton(
            label: ProjectStrings.viewChat,
            icon: Icons.chat_bubble_outline,
            backgroundColor: colors.primary.withValues(alpha: 0.18),
            foregroundColor: colors.secondary,
            onTap: () => _openChat(context),
          ),
        ),
      ],
    );
  }

  Future<void> _openChat(BuildContext context) async {
    final bloc = context.read<ProjectsFeatureBloc>();
    int? resolvedTeamId = teamId ?? bloc.state.teamSettings.data?.teamId;
    if (resolvedTeamId == null) {
      final alreadyLoading = bloc.state.teamSettingsProjectId == projectId &&
          bloc.state.teamSettings.status == ScreenDataStatus.loading;
      if (!alreadyLoading) {
        bloc.add(TeamSettingsOpened(projectId));
      }
      final stateAfter = await bloc.stream.firstWhere(
        (s) => s.teamSettings.status == ScreenDataStatus.loaded || s.teamSettings.status == ScreenDataStatus.failure,
      ).timeout(const Duration(seconds: 10), onTimeout: () => bloc.state);
      if (stateAfter.teamSettings.status == ScreenDataStatus.loaded) {
        resolvedTeamId = stateAfter.teamSettings.data?.teamId;
      }
    }
    if (resolvedTeamId == null) {
      LoggerService.warning('No team ID available for project $projectId', tag: 'ProjectDetails');
      return;
    }
    try {
      final chatRepo = sl<ChatRepository>();
      final result = await chatRepo.getRoomIdByTeamId(resolvedTeamId);
      result.fold(
        (failure) => LoggerService.warning('Chat room not found for team $resolvedTeamId', tag: 'ProjectDetails'),
        (roomId) {
          if (roomId == null) {
            LoggerService.warning('No chat room exists for team $resolvedTeamId', tag: 'ProjectDetails');
            return;
          }
          final userData = sl<AppState>().userData;
          if (userData != null) {
            final userId = int.tryParse(userData.userId) ?? 0;
            context.pushNamed(
              BridgeXRouteNames.chatDetails,
              pathParameters: {'roomId': roomId},
              extra: userId,
            );
          }
        },
      );
    } catch (e) {
      LoggerService.error('Failed to open chat', exception: e, tag: 'ProjectDetails');
    }
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.foregroundColor,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: foregroundColor, size: 20.sp),
            HorizontalSpacing(AppSpacing.xs),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.titleMedium.copyWith(
                  color: foregroundColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
