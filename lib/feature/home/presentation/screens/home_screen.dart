import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import '../widgets/ai_insights_card.dart';
import '../widgets/greeting_header.dart';
import '../widgets/productivity_section.dart';
import '../widgets/project_bars_card.dart';
import '../widgets/stats_row.dart';
import '../widgets/team_action_buttons.dart';
import '../widgets/tip_banner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.spacing20,
            vertical: AppSpacing.spacing20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GreetingHeader(),
              VerticalSpacing(AppSpacing.spacing16),
              const TipBanner(),
              VerticalSpacing(AppSpacing.spacing16),
              const TeamActionButtons(),
              VerticalSpacing(AppSpacing.spacing24),
              const StatsRow(),
              VerticalSpacing(AppSpacing.spacing24),
              const ProductivitySection(),
              VerticalSpacing(AppSpacing.spacing16),
              const ProjectBarsCard(),
              VerticalSpacing(AppSpacing.spacing16),
              const AiInsightsCard(),
            ],
          ),
        ),
      ),
    );
  }
}
