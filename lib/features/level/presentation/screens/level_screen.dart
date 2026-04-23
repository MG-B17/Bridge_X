import 'package:flutter/material.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';
import '../widgets/level_header.dart';
import '../widgets/level_activity_card.dart';
import '../widgets/level_roadmap_header.dart';
import '../widgets/level_info_card_widget.dart';
import '../widgets/roadmap_step_widget.dart';
import '../widgets/tier_card_widget.dart';

class LevelScreen extends StatelessWidget {
  const LevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LevelHeader(),
            VSpace(context.spacing.xxl),
            const TierCardWidget(
              currentTier: AppStrings.beginnerSilver,
              nextTierInfo: AppStrings.nextTierRequirement,
              progress: 0.7,
            ),
            VSpace(context.spacing.xl),
            _buildStatsRow(),
            VSpace(context.spacing.xl),
            const LevelActivityCard(),
            VSpace(context.spacing.xxl),
            const LevelRoadmapHeader(),
            VSpace(context.spacing.xl),
            const RoadmapStepWidget(
              title: AppStrings.beginnerTier,
              pills: [AppStrings.bronze, AppStrings.silver, AppStrings.gold],
              activePill: AppStrings.silver,
              isCompleted: true,
            ),
            RoadmapStepWidget(
              title: AppStrings.juniorTier,
              pills: const [AppStrings.bronze, AppStrings.silver, AppStrings.gold],
              isLocked: true,
            ),
            RoadmapStepWidget(
              title: AppStrings.seniorTier,
              pills: const [AppStrings.bronze, AppStrings.silver, AppStrings.gold],
              isLocked: true,
              showLine: false,
            ),
            VSpace(context.spacing.xxl),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: context.colors.primary),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        LevelInfoCardWidget(
          value: '128',
          label: 'Completed Tasks',
          icon: Icons.check_circle_outline_rounded,
        ),
        LevelInfoCardWidget(
          value: '4.8',
          label: AppStrings.averageRating,
          icon: Icons.star_outline_rounded,
          badge: AppStrings.top5Percent,
        ),
      ],
    );
  }
}
