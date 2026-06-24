import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_error_widget.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_refresh_indicator.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_skeletonizer.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_bloc.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_event.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_state.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/widgets/dashboard_screen_widgets/dashboard_shimmer.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/widgets/dashboard_screen_widgets/project_dashboard_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectDashboardScreen extends StatefulWidget {
  const ProjectDashboardScreen({super.key, required this.projectId});

  final int projectId;

  @override
  State<ProjectDashboardScreen> createState() =>
      _ProjectDashboardScreenState();
}

class _ProjectDashboardScreenState extends State<ProjectDashboardScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<ProjectsFeatureBloc>()
        .add(ProjectDashboardOpened(widget.projectId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsFeatureBloc, ProjectsFeatureState>(
      buildWhen: (previous, current) =>
          previous.dashboard != current.dashboard,
      builder: (context, state) {
        final ds = state.dashboard;
        final entity = ds.data;
        final isLoading = ds.status == ScreenDataStatus.loading ||
            ds.status == ScreenDataStatus.initial;
        final isRefreshing = ds.status == ScreenDataStatus.refreshing;
        final showSkeleton = isLoading || isRefreshing;
        final isFullFailure =
            ds.status == ScreenDataStatus.failure && entity == null;

        if (isFullFailure) {
          return Scaffold(
            body: SafeArea(
              child: BridgeXErrorWidget(
                errorTittle: AppStrings.error,
                errorMessage: ds.errorMessage ?? '',
                refreshButtonTap: () =>
                    context.read<ProjectsFeatureBloc>().add(
                      ProjectDashboardOpened(widget.projectId),
                    ),
              ),
            ),
          );
        }

        return Scaffold(
          body: SafeArea(
            child: BridgeXRefreshIndicator(
              onRefresh: () async =>
                  context.read<ProjectsFeatureBloc>().add(
                    const ProjectDashboardRefreshRequested(),
                  ),
              color: isRefreshing
                  ? context.colors.transparent
                  : context.colors.primary,
              backgroundColor: isRefreshing
                  ? context.colors.transparent
                  : null,
              child: BridgeXSkeletonizer(
                enableloading: showSkeleton,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.spacing20,
                    vertical: AppSpacing.spacing16,
                  ),
child: entity != null
    ? ProjectDashboardContent(project: entity)
    : const DashboardShimmer(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
