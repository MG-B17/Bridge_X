import 'package:bridge_x/core/animation/bottom_nav_bar_animation/controller/scroll_cubit.dart';
import 'package:bridge_x/core/animation/bottom_nav_bar_animation/widget/scroller_listener.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/extensions.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_error_widget.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_refresh_indicator.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_skeletonizer.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/all_projects_entity.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/projects_list/projects_list_bloc.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/projects_list/projects_list_event.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/projects_list/projects_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../widgets/projects_filter_widgets/project_filter_tabs.dart';
import '../widgets/projects_empty_state_widgets/projects_empty_state.dart';
import '../widgets/projects_header_widgets/projects_header.dart';
import '../widgets/projects_list_widgets/projects_list_content.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ProjectsScreenContent();
  }
}

class _ProjectsScreenContent extends StatefulWidget {
  const _ProjectsScreenContent();

  @override
  State<_ProjectsScreenContent> createState() => _ProjectsScreenContentState();
}

class _ProjectsScreenContentState extends State<_ProjectsScreenContent> {
  late final ScrollController scrollController;
  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
        context.read<ProjectsListBloc>().add(const LoadMoreProjects());
      }
    });
    super.initState();
  }

  @override
  dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollNavListener(
      controller: scrollController,
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<ProjectsListBloc, ProjectsListState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              if (state is ProjectsListFailure) {
                return BridgeXErrorWidget(
                  errorTittle: AppStrings.error,
                  errorMessage: state.errorMessage,
                  refreshButtonTap: () => context.read<ProjectsListBloc>().add(const LoadProjects()),
                );
              }

              final isLoading = state is ProjectsListLoading || state is ProjectsListInitial;
              final isRefreshing = state is ProjectsListRefreshing;
              final showSkeleton = isLoading || isRefreshing;

              return BridgeXSkeletonizer(
                enableloading: showSkeleton,
                child: BridgeXRefreshIndicator(
                  color: isRefreshing ? context.appColors.transparent : context.appColors.primary,
                  backgroundColor: isRefreshing ? context.appColors.transparent : null,
                  onRefresh: () async => context.read<ProjectsListBloc>().add(const RefreshProjects()),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.spacing20,
                      vertical: AppSpacing.spacing16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ProjectsHeader(),
                        VerticalSpacing(AppSpacing.spacing16),
                        _FilterTabsSelector(scrollController: scrollController),
                        VerticalSpacing(AppSpacing.spacing16),
                        _ProjectsContentSelector(scrollController: scrollController),
                        VerticalSpacing(AppSpacing.spacing32),
                      ],
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
}

class _FilterTabsSelector extends StatelessWidget {
  final ScrollController scrollController;

  const _FilterTabsSelector({required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProjectsListBloc, ProjectsListState, int>(
      selector: _extractFilter,
      builder: (context, selectedFilter) {
        return ProjectFilterTabs(
          selectedIndex: selectedFilter,
          onChanged: (filterIndex) {
            context.read<ProjectsListBloc>().add(ChangeFilter(filterIndex));
          },
        );
      },
    );
  }
}

class _ProjectsContentSelector extends StatelessWidget {
  final ScrollController scrollController;

  const _ProjectsContentSelector({required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProjectsListBloc, ProjectsListState, _ProjectsContentModel>(
      selector: (state) {
        final isLoading = state is ProjectsListLoading || state is ProjectsListInitial;
        final isLoadingMore = state is ProjectsListLoadingMore;
        final projectsData = _extractData(state);
        final selectedFilter = _extractFilter(state);
        final isTabEmpty = projectsData.isTabEmpty(selectedFilter, isLoading || isLoadingMore);

        return _ProjectsContentModel(
          projectsData: projectsData,
          selectedFilter: selectedFilter,
          isTabEmpty: isTabEmpty,
          isLoading: isLoading,
        );
      },
      builder: (context, model) {
        return model.isTabEmpty
            ? ProjectsEmptyState(
                onExploreTeams: () {},
                onCreateTeam: () {
                  context.read<ScrollCubit>().hide();
                  context.pushNamed(BridegeXRouteNames.createTeam);
                },
              )
            : ProjectsListContent(
                selectedFilter: model.selectedFilter,
                ongoingProjects: model.projectsData.ongoingProjects,
                completedProjects: model.projectsData.completedProjects,
              );
      },
    );
  }
}

int _extractFilter(ProjectsListState state) => switch (state) {
  ProjectsListLoaded(:final selectedFilter) => selectedFilter,
  ProjectsListLoadingMore(:final selectedFilter) => selectedFilter,
  ProjectsListRefreshing(:final selectedFilter) => selectedFilter,
  ProjectsListLoading(:final selectedFilter) => selectedFilter,
  ProjectsListFailure(:final selectedFilter) => selectedFilter,
  _ => 0,
};

AllProjectsEntity _extractData(ProjectsListState state) => switch (state) {
  ProjectsListLoaded(:final data) => data,
  ProjectsListLoadingMore(:final data) => data,
  ProjectsListRefreshing(:final data) => data,
  ProjectsListLoading(:final placeholderData) =>
    placeholderData ?? const AllProjectsEntity(ongoingProjects: [], completedProjects: []),
  ProjectsListFailure(:final lastData) =>
    lastData ?? const AllProjectsEntity(ongoingProjects: [], completedProjects: []),
  _ => const AllProjectsEntity(ongoingProjects: [], completedProjects: []),
};

class _ProjectsContentModel {
  final AllProjectsEntity projectsData;
  final int selectedFilter;
  final bool isTabEmpty;
  final bool isLoading;

  const _ProjectsContentModel({
    required this.projectsData,
    required this.selectedFilter,
    required this.isTabEmpty,
    required this.isLoading,
  });
}
