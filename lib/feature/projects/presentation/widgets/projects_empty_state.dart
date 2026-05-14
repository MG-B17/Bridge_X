import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';

import 'empty_state_actions.dart';
import 'empty_state_content.dart';
import 'empty_state_illustration.dart';
import 'social_proof_footer.dart';

/// Full "no projects" empty-state view composed of:
/// [EmptyStateIllustration] → [EmptyStateContent] →
/// [EmptyStateActions] → [SocialProofFooter].
///
/// Plug this into [ProjectsScreen] when the project list is empty.
class ProjectsEmptyState extends StatelessWidget {
  const ProjectsEmptyState({
    super.key,
    this.onExploreTeams,
    this.onCreateTeam,
  });

  final VoidCallback? onExploreTeams;
  final VoidCallback? onCreateTeam;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const EmptyStateIllustration(),
        VerticalSpacing(AppSpacing.lg),
        const EmptyStateContent(),
        VerticalSpacing(AppSpacing.xl),
        EmptyStateActions(
          onExploreTeams: onExploreTeams,
          onCreateTeam: onCreateTeam,
        ),
        VerticalSpacing(AppSpacing.xl),
        const SocialProofFooter(),
      ],
    );
  }
}
