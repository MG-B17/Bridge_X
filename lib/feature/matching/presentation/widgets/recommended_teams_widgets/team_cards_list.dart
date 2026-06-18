import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';

import 'package:bridge_x/feature/matching/domain/entities/team_recommendation_entity.dart';
import 'team_card.dart';

class TeamCardsList extends StatelessWidget {
  final List<TeamRecommendationEntity> recommendations;

  const TeamCardsList({super.key, required this.recommendations});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      children: [
        ...recommendations.map((rec) {
          return Padding(
            padding: EdgeInsets.only(bottom: AppSpacing.spacing16),
            child: TeamCard(
              initials: rec.teamName.isNotEmpty ? rec.teamName[0].toUpperCase() : '?',
              name: rec.teamName,
              category: '', // Handled by teamVibe in TeamCard
              description: 'Matched based on your skills and experience. ${rec.teamVibe} vibe.',
              tags: rec.matchedSkills,
              currentMembers: rec.matchedSkillsCount,
              maxMembers: rec.matchedSkillsCount + rec.missingSkillsCount,
              avatarColor: colors.primary,
              teamVibe: rec.teamVibe,
              totalMatchScore: rec.totalMatchScore,
              chemistryScore: rec.chemistryScore,
              experienceFitScore: rec.experienceFitScore,
              skillCoverage: rec.skillCoverage,
              matchedSkillsCount: rec.matchedSkillsCount,
              missingSkillsCount: rec.missingSkillsCount,
              teamId: rec.teamId,
            ),
          );
        }),
        VerticalSpacing(AppSpacing.spacing24),
      ],
    );
  }
}
