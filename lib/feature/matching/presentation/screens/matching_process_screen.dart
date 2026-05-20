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
            horizontal: AppSpacing.spacing24,
            vertical: AppSpacing.spacing16,
          ),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: BridgeXBackButton(),
              ),
              VerticalSpacing(AppSpacing.spacing24),
              const MatchingProcessTitle(),
              VerticalSpacing(AppSpacing.spacing32),
              const MatchingProgressRing(
                percentage: 45,
                label: AppStrings.optimizing,
              ),
              VerticalSpacing(AppSpacing.spacing32),
              const DynamicInsightCard(),
              VerticalSpacing(AppSpacing.spacing24),
              const SkillScanSection(),
              VerticalSpacing(AppSpacing.spacing40),
            ],
          ),
        ),
      ),
    );
  }
}
