import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';

import 'team_card.dart';

class TeamCardsList extends StatelessWidget {
  const TeamCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      children: [
        TeamCard(
          initials: 'A',
          name: 'Alpha Coders',
          category: 'Mobile App \u2022 Fintech',
          description:
              'Building a next-gen personal finance app focusing on gamified saving habits and intuitiv...',
          tags: const ['UI/UX', 'Flutter', 'Node.js'],
          currentMembers: 3,
          maxMembers: 5,
          avatarColor: colors.indigo,
        ),
        VerticalSpacing(AppSpacing.spacing16),
        TeamCard(
          initials: 'FE',
          name: 'Team up Coders',
          category: 'Mobile App \u2022 Fintech',
          description:
              'Looking for experienced React developers to help build our next-generation component...',
          tags: const ['React', 'TypeScript', 'Design Systems'],
          currentMembers: 3,
          maxMembers: 5,
          avatarColor: colors.textPrimary,
        ),
        VerticalSpacing(AppSpacing.spacing16),
        TeamCard(
          initials: 'N',
          name: 'Nexus Web',
          category: 'Web Platform \u2022 E-commerce',
          description:
              'Creating a headless e-commerce solution for local artisans to easily set up shop and sell...',
          tags: const ['React', 'GraphQL'],
          currentMembers: 4,
          maxMembers: 6,
          avatarColor: colors.success,
        ),
        VerticalSpacing(AppSpacing.spacing24),
      ],
    );
  }
}
