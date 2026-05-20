import 'package:bridge_x/core/animation/bottom_nav_bar_animation/widget/scroller_listener.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import '../widgets/home_insight_widgets/ai_insights_card.dart';
import '../widgets/home_header_widgets/greeting_header.dart';
import '../widgets/home_stats_widgets/productivity_section.dart';
import '../widgets/home_stats_widgets/project_bars_card.dart';
import '../widgets/home_stats_widgets/stats_row.dart';
import '../widgets/home_insight_widgets/team_action_buttons.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/widget/bridge_x_tip_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        body: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              left: AppSpacing.spacing20,
              right: AppSpacing.spacing20,
              top: AppSpacing.spacing20,
              bottom: AppSpacing.spacing20 + AppSpacing.spacing20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const GreetingHeader(),
                VerticalSpacing(AppSpacing.spacing16),
                const BridgeXTipBanner(message: AppStrings.tipBanner),
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
      ),
    );
  }
}
