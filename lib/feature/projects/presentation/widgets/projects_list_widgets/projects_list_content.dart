import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';

import 'completed_project_card.dart';
import 'ongoing_project_card.dart';

/// Renders the filtered list of project cards (ongoing + completed).
///
/// Extracted from [ProjectsScreen] so the screen file stays lean
/// and can cleanly swap between this and [ProjectsEmptyState].
class ProjectsListContent extends StatelessWidget {
  const ProjectsListContent({
    super.key,
    required this.selectedFilter,
  });

  final int selectedFilter;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildFilteredProjects(),
    );
  }

  List<Widget> _buildFilteredProjects() {
    // Demo data — in production this would come from a BLoC/Cubit
    final completedCards = [
      const CompletedProjectCard(
        title: 'API Gateway',
        rating: 4.9,
        description:
            'Transitioning legacy monolithic endpoints to a modern serverless architecture with improved latency and security protocols across all regions.',
        actionLabel: AppStrings.viewReport,
        date: 'Nov 04, 2023',
      ),
    ];

    final ongoingCards = [
      const OngoingProjectCard(
        title: 'FinTrack Mobile Pro',
        phase: AppStrings.developmentPhase,
        progress: 0.40,
        memberCount: 5,
        showYourTeamBadge: false,
      ),
      Padding(
        padding: EdgeInsets.only(top: AppSpacing.md),
        child: const OngoingProjectCard(
          title: 'Quantum Dashboard\nRedesign',
          phase: AppStrings.developmentPhase,
          progress: 0.80,
          memberCount: 4,
          showYourTeamBadge: true,
        ),
      ),
    ];

    switch (selectedFilter) {
      case 1: // Ongoing
        return ongoingCards;
      case 2: // Completed
        return completedCards;
      default: // All
        return [
          ...completedCards,
          VerticalSpacing(AppSpacing.md),
          ...ongoingCards,
        ];
    }
  }
}
