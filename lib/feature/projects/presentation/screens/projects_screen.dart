import 'package:bridge_x/core/animation/bottom_nav_bar_animation/controller/scroll_cubit.dart';
import 'package:bridge_x/core/animation/bottom_nav_bar_animation/widget/scroller_listener.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/extensions.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_error_widget.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_refresh_indicator.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_skeletonizer.dart';
import 'package:bridge_x/feature/projects/domain/entities/all_projects_entity.dart';
import 'package:bridge_x/feature/projects/presentation/controller/all_projects_cubit.dart';
import 'package:bridge_x/feature/projects/presentation/controller/all_projects_state.dart';
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
    return BlocProvider<AllProjectsCubit>(
      create: (context) => sl<AllProjectsCubit>()..loadProjects(),
      child: const _ProjectsScreenContent(),
    );
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
        context.read<AllProjectsCubit>().loadMore();
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
          child: BlocBuilder<AllProjectsCubit, AllProjectsState>(
            buildWhen: (previous, current) => previous.runtimeType != current.runtimeType,
            builder: (context, state) {
              if (state is AllProjectsFailure) {
                return BridgeXErrorWidget(
                  errorTittle: AppStrings.error,
                  errorMessage: state.errorMessage,
                  refreshButtonTap: () => context.read<AllProjectsCubit>().loadProjects(),
                );
              }

              final isLoading = state is AllProjectsLoading;
              final isRefreshing = state is AllProjectsRefreshing;
              final showSkeleton = isLoading || isRefreshing;

              return BridgeXSkeletonizer(
                enableloading: showSkeleton,
                child: BridgeXRefreshIndicator(
                  color: isRefreshing ? context.appColors.transparent : context.appColors.primary,
                  backgroundColor: isRefreshing ? context.appColors.transparent : null,
                  onRefresh: () => context.read<AllProjectsCubit>().refreshProjects(),
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
    return BlocSelector<AllProjectsCubit, AllProjectsState, int>(
      selector: (state) => state.selectedFilter,
      builder: (context, selectedFilter) {
        return ProjectFilterTabs(
          selectedIndex: selectedFilter,
          onChanged: (filterIndex) {
            context.read<AllProjectsCubit>().changeFilter(filterIndex);
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
    return BlocSelector<AllProjectsCubit, AllProjectsState, _ProjectsContentModel>(
      selector: (state) {
        final isLoading = state is AllProjectsLoading;
        final isLoadingMore = state is AllProjectsLoadingMore;
        final projectsData = _getProjectsData(state);
        final isTabEmpty = _isTabEmpty(
          projectsData,
          state.selectedFilter,
          isLoading || isLoadingMore,
        );

        return _ProjectsContentModel(
          projectsData: projectsData,
          selectedFilter: state.selectedFilter,
          isTabEmpty: isTabEmpty,
          isLoading: isLoading,
        );
      },
      builder: (context, model) {
        return model.isTabEmpty
            ? ProjectsEmptyState(
                onExploreTeams: () {
                  // TODO: Navigate to explore public teams
                },
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

  static AllProjectsEntity _getProjectsData(AllProjectsState state) {
    return switch (state) {
      AllProjectsLoaded s => s.data,
      AllProjectsLoadingMore s => s.data,
      AllProjectsRefreshing s => s.data,
      AllProjectsLoading s =>
        s.placeholderData ?? const AllProjectsEntity(ongoingProjects: [], completedProjects: []),
      AllProjectsFailure s =>
        s.lastData ?? const AllProjectsEntity(ongoingProjects: [], completedProjects: []),
      _ => const AllProjectsEntity(ongoingProjects: [], completedProjects: []),
    };
  }

  static bool _isTabEmpty(AllProjectsEntity projectsData, int selectedFilter, bool isLoading) {
    return projectsData.isTabEmpty(selectedFilter, isLoading);
  }
}

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
