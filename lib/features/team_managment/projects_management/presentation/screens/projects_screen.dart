import 'package:bridge_x/core/animation/bottom_nav_bar_animation/widget/scroller_listener.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_shadow.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/bridge_x_chip.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_skeletonizer.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_bloc.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_event.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_state.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/widgets/projects_header_widgets/projects_header.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/widgets/projects_tab_page.dart';
import 'package:bridge_x/features/team_managment/utils/project_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final ScrollController _scrollController;

  static const _filters = [
    ProjectStrings.all,
    ProjectStrings.ongoing,
    ProjectStrings.completed,
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        context
            .read<ProjectsFeatureBloc>()
            .add(ProjectsTabChanged(_tabController.index));
      }
    });
    _scrollController = ScrollController();
    context.read<ProjectsFeatureBloc>().add(const ProjectsLoadAllTabsRequested());
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectsFeatureBloc, ProjectsFeatureState>(
      listenWhen: (previous, current) =>
          previous.selectedTabIndex != current.selectedTabIndex,
      listener: (context, state) {
        if (state.selectedTabIndex != _tabController.index) {
          _tabController.animateTo(state.selectedTabIndex);
        }
      },
      buildWhen: (previous, current) =>
          previous.allProjects.status != current.allProjects.status,
      builder: (context, state) {
        final isInitial = state.allProjects.status == ProjectsTabStatus.initial;

        final content = NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.spacing20,
                  vertical: AppSpacing.spacing16,
                ),
                child: const ProjectsHeader(),
              ),
            ),
            SliverAppBar(
              pinned: true,
              primary: false,
              automaticallyImplyLeading: false,
              backgroundColor: context.colors.scaffoldBg,
              surfaceTintColor: Colors.transparent,
              elevation: innerBoxIsScrolled ? 2 : 0,
              toolbarHeight: AppSpacing.height72,
              titleSpacing: 0,
              title: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing20),
                child: SizedBox(
                  width: double.infinity,
                  child: ListenableBuilder(
                    listenable: _tabController,
                    builder: (context, _) => _buildChipTabs(context),
                  ),
                ),
              ),
            ),
          ],
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing20),
            child: TabBarView(
              controller: _tabController,
              children: const [
                ProjectsTabPage(tabType: ProjectsTabType.all),
                ProjectsTabPage(tabType: ProjectsTabType.ongoing),
                ProjectsTabPage(tabType: ProjectsTabType.completed),
              ],
            ),
          ),
        );

        if (isInitial) {
          return BridgeXSkeletonizer(
            enableloading: true,
            child: Scaffold(
              body: SafeArea(child: content),
            ),
          );
        }

        return ScrollNavListener(
          controller: _scrollController,
          child: Scaffold(
            body: SafeArea(child: content),
          ),
        );
      },
    );
  }

  Widget _buildChipTabs(BuildContext context) {
    return BlocBuilder<ProjectsFeatureBloc, ProjectsFeatureState>(
      buildWhen: (previous, current) =>
          previous.selectedTabIndex != current.selectedTabIndex,
      builder: (context, state) {
        return Row(
          children: List.generate(_filters.length, (index) {
            final isSelected = _tabController.index == index;
            return Padding(
              padding: EdgeInsets.only(right: AppSpacing.sm),
              child: BridgeXChip(
                label: _filters[index],
                isSelected: isSelected,
                onTap: () => _tabController.animateTo(index),
                selectedBackgroundColor: context.colors.primary,
                backgroundColor: context.colors.surface,
                selectedBorderColor: context.colors.primary,
                borderColor: context.colors.divider,
                selectedTextColor: Colors.white,
                textColor: context.colors.textPrimary,
                borderRadius: AppSpacing.radiusPill,
                boxShadow: AppShadow.subtle,
                textStyle: AppTextStyles.titleMedium.copyWith(fontSize: 13.sp),
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
