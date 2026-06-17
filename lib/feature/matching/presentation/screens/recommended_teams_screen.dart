import 'package:bridge_x/core/animation/bottom_nav_bar_animation/widget/scroller_listener.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_back_button.dart';
import 'package:bridge_x/core/widget/layout/section_header.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/feature/matching/presentation/cubit/matching_cubit.dart';
import 'package:bridge_x/feature/matching/presentation/cubit/matching_state.dart';


import '../widgets/recommended_teams_widgets/team_cards_list.dart';

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
    final cubit = sl<MatchingCubit>();
    final state = cubit.state;

    final data = state is MatchingLoaded ? state.data : null;

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
            child: BridgeXRefreshIndicator(
              color: context.colors.primary,
              onRefresh: () async => await cubit.refreshMatches(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BridgeXBackButton(onTap: () => context.goNamed(BridegeXRouteNames.home)),
                  VerticalSpacing(AppSpacing.spacing16),
                  SectionHeader(
                    title: AppStrings.recommendedForYou,
                    actionLabel: AppStrings.viewAll,
                    onAction: () {},
                  ),
                  VerticalSpacing(AppSpacing.spacing16),
                  if (data != null)
                    TeamCardsList(recommendations: data.recommendations),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
