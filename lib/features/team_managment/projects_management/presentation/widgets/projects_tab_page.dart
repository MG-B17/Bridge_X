import 'package:bridge_x/core/animation/bottom_nav_bar_animation/controller/scroll_cubit.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_names.dart';
import 'package:bridge_x/core/navigation/screens_args/project_dashboard_args.dart';
import 'package:bridge_x/core/navigation/screens_args/project_details_args.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/extensions.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_error_widget.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_snackbar.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_refresh_indicator.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_skeletonizer.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/ongoing_project_entity.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/project_item_entity.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_bloc.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_event.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_state.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/widgets/projects_empty_state_widgets/projects_empty_state.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/widgets/projects_list_widgets/completed_project_card.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/widgets/projects_list_widgets/ongoing_project_card.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/widgets/projects_list_widgets/project_list_shimmer.dart';
import 'package:bridge_x/features/team_managment/utils/project_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProjectsTabPage extends StatefulWidget {
  final ProjectsTabType tabType;

  const ProjectsTabPage({super.key, required this.tabType});

  @override
  State<ProjectsTabPage> createState() => _ProjectsTabPageState();
}

class _ProjectsTabPageState extends State<ProjectsTabPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool _onScrollNotification(ScrollNotification notification) {
    if (notification.metrics.axis != Axis.vertical ||
        notification.metrics.maxScrollExtent <= 0 ||
        notification is! ScrollUpdateNotification) {
      return false;
    }

    if (notification.metrics.pixels >=
        notification.metrics.maxScrollExtent - 200) {
      context
          .read<ProjectsFeatureBloc>()
          .add(ProjectsLoadMoreRequested(widget.tabType));
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<ProjectsFeatureBloc, ProjectsFeatureState>(
      listenWhen: (previous, current) =>
          previous.tabData(widget.tabType).errorMessage !=
              current.tabData(widget.tabType).errorMessage &&
          current.tabData(widget.tabType).errorMessage != null,
      listener: (context, state) {
        final msg = state.tabData(widget.tabType).errorMessage;
        if (msg != null) {
          BridgeXSnackBar.showError(context: context, message: msg);
        }
      },
      child: BlocBuilder<ProjectsFeatureBloc, ProjectsFeatureState>(
        buildWhen: (previous, current) {
          return previous.tabData(widget.tabType) !=
                  current.tabData(widget.tabType) ||
              previous.selectedTabIndex != current.selectedTabIndex;
        },
        builder: (context, state) {
        final tabData = state.tabData(widget.tabType);
        final isFailure =
            tabData.status == ProjectsTabStatus.failure;
        final isInitial =
            tabData.status == ProjectsTabStatus.initial;
        final isLoading =
            tabData.status == ProjectsTabStatus.loading;
        final isRefreshing =
            tabData.status == ProjectsTabStatus.refreshing;
        final showSkeleton = isLoading || isRefreshing || isInitial;

        if (isFailure && tabData.items.isEmpty) {
          return BridgeXErrorWidget(
            errorTittle: AppStrings.error,
            errorMessage: tabData.errorMessage ?? '',
            refreshButtonTap: () => context
                .read<ProjectsFeatureBloc>()
                .add(const ProjectsLoadAllTabsRequested()),
          );
        }

        final projects = tabData.items;
        final isEmpty = !isLoading && !isFailure && !isRefreshing && !isInitial && projects.isEmpty;
        final showShimmerPlaceholder = showSkeleton && projects.isEmpty;

        return NotificationListener<ScrollNotification>(
          onNotification: _onScrollNotification,
          child: BridgeXSkeletonizer(
            enableloading: showSkeleton,
            child: BridgeXRefreshIndicator(
              color: isRefreshing
                  ? context.appColors.transparent
                  : context.appColors.primary,
              backgroundColor: isRefreshing
                  ? context.appColors.transparent
                  : null,
              onRefresh: () async => context
                  .read<ProjectsFeatureBloc>()
                  .add(const ProjectsPullToRefreshRequested()),
              child: showShimmerPlaceholder
                  ? const ProjectListShimmer()
                  : isEmpty
                  ? ProjectsEmptyState(
                      onExploreTeams: () {
                        context.read<ScrollCubit>().hide();
                        context.pushNamed(BridgeXRouteNames.selectCategory);
                      },
                      onCreateTeam: () {
                        context.read<ScrollCubit>().hide();
                        context.pushNamed(BridgeXRouteNames.createTeam);
                      },
                    )
                  : ListView.separated(
                      key: PageStorageKey<String>(
                        'projects-tab-${widget.tabType.name}',
                      ),
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.only(
                        top: AppSpacing.spacing16,
                        bottom: AppSpacing.spacing32,
                      ),
                      itemCount:
                          projects.length +
                          (tabData.status == ProjectsTabStatus.loadingMore
                              ? 1
                              : 0) +
                          (tabData.errorMessage != null &&
                                  tabData.status ==
                                      ProjectsTabStatus.loaded
                              ? 1
                              : 0),
                      separatorBuilder: (context, index) =>
                          VerticalSpacing(AppSpacing.md),
                      itemBuilder: (context, index) {
                        final loadingMoreFooter =
                            tabData.status ==
                                    ProjectsTabStatus.loadingMore &&
                                index >= projects.length;
                        final retryFooter =
                            tabData.errorMessage != null &&
                                tabData.status ==
                                    ProjectsTabStatus.loaded &&
                                !loadingMoreFooter &&
                                index >= projects.length;

                        if (loadingMoreFooter) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        if (retryFooter) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: TextButton.icon(
                                onPressed: () => context
                                    .read<ProjectsFeatureBloc>()
                                    .add(ProjectsLoadMoreRequested(
                                        widget.tabType)),
                                icon: const Icon(Icons.refresh),
                                label: Text(AppStrings.tryAgain),
                              ),
                            ),
                          );
                        }

                        return _buildProjectCard(context, projects[index]);
                      },
                    ),
            ),
          ),
        );
      },
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, ProjectItemEntity project) {
    if (project.isCompleted) {
      return CompletedProjectCard(
        title: project.title,
        rating: 0,
        description: project.description,
        actionLabel: ProjectStrings.viewReport,
        date: project.completionDate ?? project.expectedEndDate,
        onActionTap: () {
          context.read<ScrollCubit>().hide();
          context.pushNamed(
            BridgeXRouteNames.completedProjectDetails,
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
        isLeader: project.isLeader,
        memberCount: project.yourTeam?.teamSize ?? 0,
      ),
      onYourTeamTap: () {
        context.read<ScrollCubit>().hide();
        context.pushNamed(
          BridgeXRouteNames.projectDashboard,
          extra: ProjectDashboardArgs(projectId: project.id),
        );
      },
      onDetailsTap: () {
        context.read<ScrollCubit>().hide();
        context.pushNamed(
          BridgeXRouteNames.projectDetails,
          extra: ProjectDetailsArgs(projectId: project.id, status: 'ongoing'),
        );
      },
    );
  }
}
