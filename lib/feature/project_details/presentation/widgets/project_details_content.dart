import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/project_details/domain/entities/project_details_entity.dart';
import 'package:bridge_x/feature/project_details/presentation/widgets/github_link_section.dart';
import 'package:bridge_x/feature/project_details/presentation/widgets/my_role_card.dart';
import 'package:bridge_x/feature/project_details/presentation/widgets/project_details_action_buttons.dart';
import 'package:bridge_x/feature/project_details/presentation/widgets/project_header_card.dart';
import 'package:bridge_x/feature/project_details/presentation/widgets/team_members_section.dart';
import 'package:flutter/material.dart';

class ProjectDetailsContent extends StatelessWidget {
  const ProjectDetailsContent({super.key, required this.project});

  final ProjectDetailsEntity project;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProjectHeaderCard(project: project),
        VerticalSpacing(AppSpacing.spacing16),
        MyRoleCard(myTrack: project.myTrack),
        if (project.hasGithubLink) ...[
          VerticalSpacing(AppSpacing.spacing16),
          GithubLinkSection(githubLink: project.githubLink!),
        ],
        VerticalSpacing(AppSpacing.spacing16),
        TeamMembersSection(
          teamMembers: project.teamMembers,
          teamMembersCount: project.teamMembersCount,
        ),
        VerticalSpacing(AppSpacing.spacing24),
        const ProjectDetailsActionButtons(),
        VerticalSpacing(AppSpacing.spacing32),
      ],
    );
  }
}
