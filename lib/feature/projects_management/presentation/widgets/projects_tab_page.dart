import 'package:bridge_x/core/animation/bottom_nav_bar_animation/controller/scroll_cubit.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/navigation/screens_args/project_dashboard_args.dart';
import 'package:bridge_x/core/navigation/screens_args/project_details_args.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/extensions.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_error_widget.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_refresh_indicator.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_skeletonizer.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/ongoing_project_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/project_item_entity.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/projects_tab/projects_tab_bloc.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/projects_tab/projects_tab_event.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/projects_tab/projects_tab_state.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/projects_empty_state_widgets/projects_empty_state.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/projects_list_widgets/completed_project_card.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/projects_list_widgets/ongoing_project_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProjectsTabPage extends StatefulWidget {
  const ProjectsTabPage({super.key});

  @override
  State<ProjectsTabPage> createState() => _ProjectsTabPageState();
}

class _ProjectsTabPageState extends State<ProjectsTabPage>
    with AutomaticKeepAliveClientMixin {
  late final ScrollController _scrollController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<ProjectsTabBloc>().add(const LoadMoreProjectsTab());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<ProjectsTabBloc, ProjectsTabState>(
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType ||
          current is ProjectsTabLoaded ||
          current is ProjectsTabFailure,
      builder: (context, state) {
        if (state is ProjectsTabFailure && state.lastData == null) {
          return BridgeXErrorWidget(
            errorTittle: AppStrings.error,
            errorMessage: state.errorMessage,
            refreshButtonTap: () =>
                context.read<ProjectsTabBloc>().add(const LoadProjectsTab()),
          );
        }

        final isLoading = state is ProjectsTabLoading || state is ProjectsTabInitial;
        final isRefreshing = state is ProjectsTabRefreshing;
        final isFailure = state is ProjectsTabFailure;
        final showSkeleton = isLoading || isRefreshing;
        final projects = _extractProjects(state);
        final isEmpty = !isLoading && !isFailure && projects.isEmpty;

        return BridgeXSkeletonizer(
          enableloading: showSkeleton,
          child: BridgeXRefreshIndicator(
            color: isRefreshing
                ? context.appColors.transparent
                : context.appColors.primary,
            backgroundColor:
                isRefreshing ? context.appColors.transparent : null,
            onRefresh: () async =>
                context.read<ProjectsTabBloc>().add(const RefreshProjectsTab()),
            child: isEmpty
                ? ProjectsEmptyState(
                    onExploreTeams: () {},
                    onCreateTeam: () {
                      context.read<ScrollCubit>().hide();
                      context.pushNamed(BridegeXRouteNames.createTeam);
                    },
                  )
                : ListView.separated(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(
                      bottom: AppSpacing.spacing32,
                    ),
                    itemCount:
                        projects.length + (state is ProjectsTabLoadingMore ? 1 : 0),
                    separatorBuilder: (context, index) =>
                        VerticalSpacing(AppSpacing.md),
                    itemBuilder: (context, index) {
                      if (index >= projects.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return _buildProjectCard(context, projects[index]);
                    },
                  ),
          ),
        );
      },
    );
  }

  List<ProjectItemEntity> _extractProjects(ProjectsTabState state) =>
      switch (state) {
        ProjectsTabLoaded(:final projects) => projects,
        ProjectsTabLoadingMore(:final projects) => projects,
        ProjectsTabRefreshing(:final projects) => projects,
        ProjectsTabLoading(:final placeholderData) => placeholderData,
        ProjectsTabFailure(:final lastData) => lastData ?? [],
        _ => [],
      };

  Widget _buildProjectCard(BuildContext context, ProjectItemEntity project) {
    if (project.isCompleted) {
      return CompletedProjectCard(
        title: project.title,
        rating: 0,
        description: project.description,
        actionLabel: AppStrings.viewReport,
        date: project.completionDate ?? project.expectedEndDate,
        onActionTap: () {
          context.read<ScrollCubit>().hide();
          context.pushNamed(
            BridegeXRouteNames.completedProjectDetails,
            extra: ProjectDetailsArgs(
              projectId: project.id,
              status: 'completed',
            ),
          );
        },
      );
    }

    return OngoingProjectCard(
      entity: OngoingProjectEntity(
        id: project.id,
        title: project.title,
        description: project.description,
        category: project.category,
        estimatedDurationDays: project.estimatedDurationDays,
        expectedEndDate: project.expectedEndDate,
        projectCompletionPercentage: project.projectCompletionPercentage,
        myCompletionPercentage: project.myCompletionPercentage,
        mySpecialization: project.mySpecialization,
      ),
      onYourTeamTap: () {
        context.read<ScrollCubit>().hide();
        context.pushNamed(
          BridegeXRouteNames.projectDashboard,
          extra: ProjectDashboardArgs(projectId: project.id),
        );
      },
      onDetailsTap: () {
        context.read<ScrollCubit>().hide();
        context.pushNamed(
          BridegeXRouteNames.projectDetails,
          extra: ProjectDetailsArgs(projectId: project.id, status: 'ongoing'),
        );
      },
    );
  }
}
