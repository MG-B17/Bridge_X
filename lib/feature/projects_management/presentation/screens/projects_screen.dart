import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_shadow.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/bridge_x_chip.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/projects_management/domain/usecases/get_projects_usecase.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/projects_tab/projects_tab_bloc.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/projects_tab/projects_tab_event.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/projects_header_widgets/projects_header.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/projects_tab_page.dart';
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
  late final ProjectsTabBloc _allBloc;
  late final ProjectsTabBloc _ongoingBloc;
  late final ProjectsTabBloc _completedBloc;

  static const _filters = [
    AppStrings.all,
    AppStrings.ongoing,
    AppStrings.completed,
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    final useCase = sl<GetProjectsUseCase>();
    _allBloc = ProjectsTabBloc(getProjectsUseCase: useCase, status: null)
      ..add(const LoadProjectsTab());
    _ongoingBloc =
        ProjectsTabBloc(getProjectsUseCase: useCase, status: 'ongoing')
          ..add(const LoadProjectsTab());
    _completedBloc =
        ProjectsTabBloc(getProjectsUseCase: useCase, status: 'completed')
          ..add(const LoadProjectsTab());
  }

  @override
  void dispose() {
    _tabController.dispose();
    _allBloc.close();
    _ongoingBloc.close();
    _completedBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.spacing20,
                vertical: AppSpacing.spacing16,
              ),
              child: const ProjectsHeader(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing20),
              child: ListenableBuilder(
                listenable: _tabController,
                builder: (context, _) => _buildChipTabs(context),
              ),
            ),
            VerticalSpacing(AppSpacing.spacing16),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing20),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    BlocProvider.value(
                      value: _allBloc,
                      child: const ProjectsTabPage(),
                    ),
                    BlocProvider.value(
                      value: _ongoingBloc,
                      child: const ProjectsTabPage(),
                    ),
                    BlocProvider.value(
                      value: _completedBloc,
                      child: const ProjectsTabPage(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChipTabs(BuildContext context) {
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
  }
}
