import 'package:bridge_x/core/animation/bottom_nav_bar_animation/widget/scroller_listener.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/bridge_x_back_button.dart';
import 'package:bridge_x/core/widget/section_header.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/recommended_teams_widgets/team_cards_list.dart';
import '../widgets/no_teams_found_widgets/try_again_button.dart';

class RecommendedTeamsScreen extends StatefulWidget {
  const RecommendedTeamsScreen({super.key});

  @override
  State<RecommendedTeamsScreen> createState() => _RecommendedTeamsScreenState();
}

class _RecommendedTeamsScreenState extends State<RecommendedTeamsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ScrollNavListener(
      controller: _scrollController,
      child: Scaffold(
        backgroundColor: colors.scaffoldBg,
        body: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              left: AppSpacing.spacing16,
              right: AppSpacing.spacing16,
              top: AppSpacing.spacing16,
              bottom: AppSpacing.spacing16 + AppSpacing.spacing20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BridgeXBackButton(),
                VerticalSpacing(AppSpacing.spacing16),
                TryAgainButton(
                  onTap: () {
                    context.pushReplacementNamed(BridegeXRouteNames.matchingProcess);
                  },
                ),
                VerticalSpacing(AppSpacing.spacing24),
                SectionHeader(
                  title: AppStrings.recommendedForYou,
                  actionLabel: AppStrings.viewAll,
                  onAction: () {
                    // TODO: View all
                  },
                ),
                VerticalSpacing(AppSpacing.spacing16),
                const TeamCardsList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
