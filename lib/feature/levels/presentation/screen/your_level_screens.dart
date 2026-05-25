import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../widget/your_level_screen_widget/your_level_header.dart';
import '../widget/your_level_screen_widget/current_tier_card.dart';
import '../widget/your_level_screen_widget/level_stats_row.dart';
import '../widget/your_level_screen_widget/ai_consistency_banner.dart';
import '../widget/your_level_screen_widget/level_roadmap_section.dart';

import 'package:bridge_x/core/animation/bottom_nav_bar_animation/widget/scroller_listener.dart';

class YourLevelScreen extends StatefulWidget {
  const YourLevelScreen({super.key});

  @override
  State<YourLevelScreen> createState() => _YourLevelScreenState();
}

class _YourLevelScreenState extends State<YourLevelScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollNavListener(
      controller: _scrollController,
      child: Scaffold(
        backgroundColor: context.colors.scaffoldBg,
        body: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.only(
              left: AppSpacing.spacing20,
              right: AppSpacing.spacing20,
              top: AppSpacing.spacing16,
              bottom: AppSpacing.spacing16 + AppSpacing.spacing20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const YourLevelHeader(),
                VerticalSpacing(AppSpacing.spacing24),
                const CurrentTierCard(),
                VerticalSpacing(AppSpacing.spacing20),
                const LevelStatsRow(),
                VerticalSpacing(AppSpacing.spacing20),
                const AiConsistencyBanner(),
                VerticalSpacing(AppSpacing.spacing24),
                const LevelRoadmapSection(),
                VerticalSpacing(AppSpacing.spacing32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
