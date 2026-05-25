import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/details/completed_project_details_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/details/project_details_entity.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/details_screen_widgets/duration_completion_cards.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/details_screen_widgets/github_link_section.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/details_screen_widgets/my_role_card.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/details_screen_widgets/project_details_action_buttons.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/details_screen_widgets/project_header_card.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/details_screen_widgets/rating_feedback_card.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/details_screen_widgets/team_members_section.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/details_screen_widgets/your_impact_section.dart';
import 'package:flutter/material.dart';

class CompletedProjectDetailsContent extends StatelessWidget {
  const CompletedProjectDetailsContent({super.key, required this.project});

  final CompletedProjectDetailsEntity project;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProjectHeaderCard(
          project: ProjectDetailsEntity(
            id: project.id,
            title: project.title,
            description: project.description,
            status: project.status,
            myTrack: project.myTrack,
            githubLink: project.githubLink,
            teamMembers: project.teamMembers,
            teamMembersCount: project.teamMembers.length,
          ),
        ),
        VerticalSpacing(AppSpacing.spacing16),
        MyRoleCard(myTrack: project.myTrack),
        if (project.hasGithubLink) ...[
          VerticalSpacing(AppSpacing.spacing16),
          GithubLinkSection(githubLink: project.githubLink!),
        ],
        VerticalSpacing(AppSpacing.spacing16),
        TeamMembersSection(
          teamMembers: project.teamMembers,
          teamMembersCount: project.teamMembers.length,
        ),
        VerticalSpacing(AppSpacing.spacing16),
        RatingFeedbackCard(
          myRating: project.myRating,
          feedbacks: project.feedbacks,
        ),
        VerticalSpacing(AppSpacing.spacing16),
        DurationCompletionCards(
          durationDays: project.durationDays,
          completionDate: project.completionDate,
        ),
        VerticalSpacing(AppSpacing.spacing16),
        YourImpactSection(impacts: project.impacts),
        VerticalSpacing(AppSpacing.spacing24),
        const ProjectDetailsActionButtons(),
        VerticalSpacing(AppSpacing.spacing32),
      ],
    );
  }
}
