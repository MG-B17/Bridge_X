import 'package:bridge_x/core/animation/bottom_nav_bar_animation/widget/scroller_listener.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_back_button.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_button.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_outline_button.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/no_teams_found_widgets/no_teams_illustration.dart';
import '../widgets/no_teams_found_widgets/no_teams_title.dart';

class NoTeamsFoundScreen extends StatefulWidget {
  const NoTeamsFoundScreen({super.key});

  @override
  State<NoTeamsFoundScreen> createState() => _NoTeamsFoundScreenState();
}

class _NoTeamsFoundScreenState extends State<NoTeamsFoundScreen> {
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
              left: AppSpacing.spacing24,
              right: AppSpacing.spacing24,
              top: AppSpacing.spacing16,
              bottom: AppSpacing.spacing32 + AppSpacing.spacing20,
            ),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: BridgeXBackButton(),
                ),
                VerticalSpacing(AppSpacing.spacing40),
                const NoTeamsIllustration(),
                VerticalSpacing(AppSpacing.spacing32),
                const NoTeamsTitle(),
                VerticalSpacing(AppSpacing.spacing40),
                BridgeXButton(
                  text: AppStrings.retryMatching,
                  prefixicon: Icons.refresh_rounded,
                  onTap: () {
                    context.pushReplacementNamed(BridegeXRouteNames.matchingProcess);
                  },
                ),
                VerticalSpacing(AppSpacing.spacing16),
                BridgeXOutlineButton(
                  text: AppStrings.createYourOwnTeam,
                  onTap: () {
                    context.pushNamed(BridegeXRouteNames.createTeam);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
