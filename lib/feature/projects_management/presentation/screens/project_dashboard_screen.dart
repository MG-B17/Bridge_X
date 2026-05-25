import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_error_widget.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_refresh_indicator.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_skeletonizer.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/dashboard/project_dashboard_entity.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/project_dashboard/project_dashboard_bloc.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/project_dashboard/project_dashboard_event.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/project_dashboard/project_dashboard_state.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/dashboard_screen_widgets/project_dashboard_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectDashboardScreen extends StatelessWidget {
  const ProjectDashboardScreen({super.key, required this.projectId});

  final int projectId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProjectDashboardBloc>(
      create: (_) =>
          sl<ProjectDashboardBloc>()..add(LoadDashboard(projectId)),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<ProjectDashboardBloc, ProjectDashboardState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              if (state is ProjectDashboardError) {
                return BridgeXErrorWidget(
                  errorTittle: AppStrings.error,
                  errorMessage: state.message,
                  refreshButtonTap: () =>
                      context.read<ProjectDashboardBloc>().add(const RetryDashboard()),
                );
              }

              final isLoading =
                  state is ProjectDashboardInitial ||
                  state is ProjectDashboardLoading;
              final isRefreshing = state is ProjectDashboardRefreshing;

              return BridgeXRefreshIndicator(
                onRefresh: () async =>
                    context.read<ProjectDashboardBloc>().add(const RefreshDashboard()),
                color: isRefreshing
                    ? context.colors.transparent
                    : context.colors.primary,
                backgroundColor: isRefreshing
                    ? context.colors.transparent
                    : null,
                child: BridgeXSkeletonizer(
                  enableloading: isLoading || isRefreshing,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.spacing20,
                      vertical: AppSpacing.spacing16,
                    ),
                    child: ProjectDashboardContent(
                      project: _resolveProject(state),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  ProjectDashboardEntity _resolveProject(ProjectDashboardState state) {
    return switch (state) {
      ProjectDashboardLoaded(:final dashboard) => dashboard,
      ProjectDashboardRefreshing(:final dashboard) => dashboard,
      ProjectDashboardLoading(:final placeholderData) =>
        placeholderData ?? const ProjectDashboardEntity(
          projectId: 0,
          projectTitle: '',
          description: '',
          totalMembers: 0,
          pendingTasks: 0,
          members: [],
        ),
      _ => const ProjectDashboardEntity(
        projectId: 0,
        projectTitle: '',
        description: '',
        totalMembers: 0,
        pendingTasks: 0,
        members: [],
      ),
    };
  }
}
