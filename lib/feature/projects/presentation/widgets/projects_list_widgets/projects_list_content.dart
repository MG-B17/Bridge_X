import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/navigation/screens_args/project_details_args.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/projects/domain/entities/completed_project_entity.dart';
import 'package:bridge_x/feature/projects/domain/entities/ongoing_project_entity.dart';
import 'package:flutter/material.dart';
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
    final ongoingCount = _showOngoing ? ongoingProjects.length : 0;
    final completedCount = _showCompleted ? completedProjects.length : 0;
    final totalCount = ongoingCount + completedCount;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: totalCount + (totalCount > 1 ? totalCount - 1 : 0),
      itemBuilder: (context, index) => _buildItem(context, index),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    int itemIndex = 0;

    if (_showCompleted) {
      for (int i = 0; i < completedProjects.length; i++) {
        if (itemIndex == index) return _buildCompletedCard(completedProjects[i]);
        itemIndex++;
        if (i < completedProjects.length - 1) {
          if (itemIndex == index) return VerticalSpacing(AppSpacing.md);
          itemIndex++;
        }
      }
    }

    if (_showOngoing) {
      if (_showCompleted && completedProjects.isNotEmpty) {
        if (itemIndex == index) return VerticalSpacing(AppSpacing.md);
        itemIndex++;
      }
      for (int i = 0; i < ongoingProjects.length; i++) {
        if (itemIndex == index) return _buildOngoingCard(context, ongoingProjects[i]);
        itemIndex++;
        if (i < ongoingProjects.length - 1) {
          if (itemIndex == index) return VerticalSpacing(AppSpacing.md);
          itemIndex++;
        }
      }
    }

    return const SizedBox.shrink();
  }

  Widget _buildOngoingCard(BuildContext context, OngoingProjectEntity ongoing) {
    return OngoingProjectCard(
      entity: ongoing,
      onDetailsTap: () => context.pushNamed(
        BridegeXRouteNames.projectDetails,
        extra: ProjectDetailsArgs(
          projectId: ongoing.id,
          status: 'ongoing',
        ),
      ),
    );
  }

  Widget _buildCompletedCard(CompletedProjectEntity completed) {
    return CompletedProjectCard(
      title: completed.title,
      rating: 4.8,
      description: completed.description,
      actionLabel: AppStrings.viewReport,
      date: completed.expectedEndDate,
    );
  }
}
