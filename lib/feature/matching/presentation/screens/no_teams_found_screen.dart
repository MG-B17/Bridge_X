import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/bridge_x_back_button.dart';
import 'package:bridge_x/core/widget/bridge_x_button.dart';
import 'package:bridge_x/core/widget/bridge_x_outline_button.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/no_teams_illustration.dart';
import '../widgets/no_teams_title.dart';

class NoTeamsFoundScreen extends StatelessWidget {
  const NoTeamsFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.scaffoldBg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.md),
          child: Column(
            children: [
              // ── Back button ──
              const Align(alignment: Alignment.centerLeft, child: BridgeXBackButton()),

              // ── Illustration placeholder ──
              const NoTeamsIllustration(),
              VerticalSpacing(AppSpacing.xxl),

              // ── Title ──
              const NoTeamsTitle(),
              const Spacer(flex: 1),

              // ── Retry Matching (filled) ──
              BridgeXButton(
                text: AppStrings.retryMatching,
                prefixicon: Icons.refresh_rounded,
                onTap: () {
                  context.pushReplacementNamed(BridegeXRouteNames.matchingProcess);
                },
              ),
              VerticalSpacing(AppSpacing.md),

              // ── Create Your Own Team (outlined) ──
              BridgeXOutlineButton(
                text: AppStrings.createYourOwnTeam,
                onTap: () {
                  context.pushNamed(BridegeXRouteNames.createTeam);
                },
              ),
              VerticalSpacing(AppSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }
}
