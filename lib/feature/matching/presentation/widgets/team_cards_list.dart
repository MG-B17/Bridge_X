import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'team_card.dart';

/// Renders the demo list of recommended team cards.
///
/// In production the data would come from a BLoC/Cubit; for now
/// this keeps the screen file focused on layout orchestration.
class TeamCardsList extends StatelessWidget {
  const TeamCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TeamCard(
          initials: 'A',
          name: 'Alpha Coders',
          category: 'Mobile App • Fintech',
          description:
              'Building a next-gen personal finance app focusing on gamified saving habits and intuitiv...',
          tags: ['UI/UX', 'Flutter', 'Node.js'],
          currentMembers: 3,
          maxMembers: 5,
          avatarColor: Color(0xFF4F46E5),
        ),
        VerticalSpacing(AppSpacing.md),
        const TeamCard(
          initials: 'FE',
          name: 'Team up Coders',
          category: 'Mobile App • Fintech',
          description:
              'Looking for experienced React developers to help build our next-generation component...',
          tags: ['React', 'TypeScript', 'Design Systems'],
          currentMembers: 3,
          maxMembers: 5,
          avatarColor: Color(0xFF1F2937),
        ),
        VerticalSpacing(AppSpacing.md),
        const TeamCard(
          initials: 'N',
          name: 'Nexus Web',
          category: 'Web Platform • E-commerce',
          description:
              'Creating a headless e-commerce solution for local artisans to easily set up shop and sell...',
          tags: ['React', 'GraphQL'],
          currentMembers: 4,
          maxMembers: 6,
          avatarColor: Color(0xFF059669),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
