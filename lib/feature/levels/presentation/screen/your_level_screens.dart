import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../widget/your_level_screen_widget/your_level_header.dart';
import '../widget/your_level_screen_widget/current_tier_card.dart';
import '../widget/your_level_screen_widget/level_stats_row.dart';
import '../widget/your_level_screen_widget/ai_consistency_banner.dart';
import '../widget/your_level_screen_widget/level_roadmap_section.dart';

class YourLevelScreen extends StatelessWidget {
  const YourLevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const YourLevelHeader(),
              VerticalSpacing(AppSpacing.xl),
              const CurrentTierCard(),
              VerticalSpacing(AppSpacing.lg),
              const LevelStatsRow(),
              VerticalSpacing(AppSpacing.lg),
              const AiConsistencyBanner(),
              VerticalSpacing(AppSpacing.xl),
              const LevelRoadmapSection(),
              VerticalSpacing(AppSpacing.xxl), // extra padding at bottom
            ],
          ),
        ),
      ),
    );
  }
}
