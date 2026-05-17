import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/bridge_x_back_button.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:bridge_x/feature/matching/presentation/widgets/dynamic_insight_card.dart';
import 'package:bridge_x/feature/matching/presentation/widgets/matching_progress_ring.dart';
import 'package:bridge_x/feature/matching/presentation/widgets/skill_scan_section.dart';
import 'package:flutter/material.dart';

import '../widgets/matching_process_title.dart';

class MatchingProcessScreen extends StatelessWidget {
  const MatchingProcessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          child: Column(
            children: [
              // ── Back button ──
              const Align(
                alignment: Alignment.centerLeft,
                child: BridgeXBackButton(),
              ),
              VerticalSpacing(AppSpacing.xl),

              // ── Title ──
              const MatchingProcessTitle(),
              VerticalSpacing(AppSpacing.xxl),

              // ── Progress ring ──
              const MatchingProgressRing(
                percentage: 45,
                label: AppStrings.optimizing,
              ),
              VerticalSpacing(AppSpacing.xxl),

              // ── Dynamic insight card ──
              const DynamicInsightCard(),
              VerticalSpacing(AppSpacing.xl),

              // ── Skill scan ──
              const SkillScanSection(),
              VerticalSpacing(AppSpacing.section),
            ],
          ),
        ),
      ),
    );
  }
}
