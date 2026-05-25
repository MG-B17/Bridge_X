import 'package:bridge_x/core/animation/bottom_nav_bar_animation/controller/scroll_cubit.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/navigation/screens_args/project_dashboard_args.dart';
import 'package:bridge_x/core/navigation/screens_args/project_details_args.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/completed_project_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/ongoing_project_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'completed_project_card.dart';
import 'ongoing_project_card.dart';

class ProjectsListContent extends StatelessWidget {
  const ProjectsListContent({
    super.key,
    required this.selectedFilter,
    required this.ongoingProjects,
    required this.completedProjects,
  });

  final int selectedFilter;
  final List<OngoingProjectEntity> ongoingProjects;
  final List<CompletedProjectEntity> completedProjects;

  bool get _showOngoing => selectedFilter != 2;
  bool get _showCompleted => selectedFilter != 1;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];

    if (_showCompleted) {
      for (int i = 0; i < completedProjects.length; i++) {
        if (i > 0) children.add(VerticalSpacing(AppSpacing.md));
        children.add(_buildCompletedCard(context, completedProjects[i]));
      }
    }

    if (_showOngoing) {
      if (_showCompleted && completedProjects.isNotEmpty && ongoingProjects.isNotEmpty) {
        children.add(VerticalSpacing(AppSpacing.md));
      }
      for (int i = 0; i < ongoingProjects.length; i++) {
        if (i > 0) children.add(VerticalSpacing(AppSpacing.md));
        children.add(_buildOngoingCard(context, ongoingProjects[i]));
      }
    }

    return Column(children: children);
  }

  Widget _buildOngoingCard(BuildContext context, OngoingProjectEntity ongoing) {
    return OngoingProjectCard(
      entity: ongoing,
      onYourTeamTap: () {
        context.read<ScrollCubit>().hide();
        context.pushNamed(
          BridegeXRouteNames.projectDashboard,
          extra: ProjectDashboardArgs(projectId: ongoing.id),
        );
      },
      onDetailsTap: () {
        context.read<ScrollCubit>().hide();
        context.pushNamed(
          BridegeXRouteNames.projectDetails,
          extra: ProjectDetailsArgs(projectId: ongoing.id, status: 'ongoing'),
        );
      },
    );
  }

  Widget _buildCompletedCard(BuildContext context, CompletedProjectEntity completed) {
    return CompletedProjectCard(
      title: completed.title,
      rating: 4.8,
      description: completed.description,
      actionLabel: AppStrings.viewReport,
      date: completed.expectedEndDate,
      onActionTap: () {
        context.read<ScrollCubit>().hide();
        context.pushNamed(
          BridegeXRouteNames.completedProjectDetails,
          extra: ProjectDetailsArgs(projectId: completed.id, status: 'completed'),
        );
      },
    );
  }
}
