import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/dashboard/project_dashboard_entity.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/widgets/dashboard_screen_widgets/action_buttons_section.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/widgets/dashboard_screen_widgets/completion_card.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/widgets/dashboard_screen_widgets/project_dashboard_header.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/widgets/dashboard_screen_widgets/stats_cards_row.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/widgets/dashboard_screen_widgets/team_members_section.dart';
import 'package:flutter/material.dart';

class ProjectDashboardContent extends StatelessWidget {
  final ProjectDashboardEntity project;

  const ProjectDashboardContent({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProjectDashboardHeader(project: project),
        VerticalSpacing(AppSpacing.spacing16),
        StatsCardsRow(project: project),
        VerticalSpacing(AppSpacing.spacing24),
        TeamMembersSection(project: project),
        VerticalSpacing(AppSpacing.spacing24),
        ActionButtonsSection(projectId: project.projectId),
        VerticalSpacing(AppSpacing.spacing24),
        CompletionCard(projectId: project.projectId),
        
        VerticalSpacing(AppSpacing.spacing16),
      ],
    );
  }
}
