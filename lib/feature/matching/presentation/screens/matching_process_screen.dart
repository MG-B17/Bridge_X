import 'dart:async';

import 'package:bridge_x/core/animation/bottom_nav_bar_animation/widget/scroller_listener.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/bridge_x_back_button.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:bridge_x/feature/matching/presentation/widgets/matching_process_widgets/dynamic_insight_card.dart';
import 'package:bridge_x/feature/matching/presentation/widgets/matching_process_widgets/matching_progress_ring.dart';
import 'package:bridge_x/feature/matching/presentation/widgets/matching_process_widgets/skill_scan_section.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/matching_process_widgets/matching_process_title.dart';

class MatchingProcessScreen extends StatefulWidget {
  const MatchingProcessScreen({super.key});

  @override
  State<MatchingProcessScreen> createState() => _MatchingProcessScreenState();
}

class _MatchingProcessScreenState extends State<MatchingProcessScreen> {
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _nextScreen();
  }

  void _nextScreen() {
    _timer = Timer(const Duration(seconds: 4), () {
      if (mounted) {
        context.goNamed(BridegeXRouteNames.noTeamsFound);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
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
              left: AppSpacing.spacing24,
              right: AppSpacing.spacing24,
              top: AppSpacing.spacing16,
              bottom: AppSpacing.spacing16 + AppSpacing.spacing20,
            ),
            child: Column(
            children: [
              const Align(alignment: Alignment.centerLeft, child: BridgeXBackButton()),
              VerticalSpacing(AppSpacing.spacing24),
              const MatchingProcessTitle(),
              VerticalSpacing(AppSpacing.spacing32),
              const MatchingProgressRing(percentage: 45, label: AppStrings.optimizing),
              VerticalSpacing(AppSpacing.spacing32),
              const DynamicInsightCard(),
              VerticalSpacing(AppSpacing.spacing24),
              const SkillScanSection(),
              VerticalSpacing(AppSpacing.spacing40),
            ],
          ),
        ),
      ),
    ),
  );
}
}
