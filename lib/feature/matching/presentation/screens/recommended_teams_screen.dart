import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/bridge_x_back_button.dart';
import 'package:bridge_x/core/widget/section_header.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../widgets/team_cards_list.dart';
import '../widgets/try_again_button.dart';

class RecommendedTeamsScreen extends StatelessWidget {
  const RecommendedTeamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Back button ──
              const BridgeXBackButton(),
              VerticalSpacing(AppSpacing.md),

              // ── Try Again ──
              TryAgainButton(
                onTap: () {
                  // TODO: Retry matching
                },
              ),
              VerticalSpacing(AppSpacing.xl),

              // ── Section header ──
              SectionHeader(
                title: AppStrings.recommendedForYou,
                actionLabel: AppStrings.viewAll,
                onAction: () {
                  // TODO: View all
                },
              ),
              VerticalSpacing(AppSpacing.md),

              // ── Team cards ──
              const TeamCardsList(),
            ],
          ),
        ),
      ),
    );
  }
}
