import 'package:bridge_x/core/animation/bottom_nav_bar_animation/widget/scroller_listener.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_back_button.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/feature/matching/presentation/cubit/matching_cubit.dart';
import 'package:bridge_x/feature/matching/presentation/cubit/matching_state.dart';
import 'package:bridge_x/feature/matching/presentation/widgets/matching_process_widgets/dynamic_insight_card.dart';
import 'package:bridge_x/feature/matching/presentation/widgets/matching_process_widgets/matching_progress_ring.dart';
import 'package:bridge_x/feature/matching/presentation/widgets/matching_process_widgets/skill_scan_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../widgets/matching_process_widgets/matching_process_title.dart';

class MatchingProcessScreen extends StatefulWidget {
  const MatchingProcessScreen({super.key});

  @override
  State<MatchingProcessScreen> createState() => _MatchingProcessScreenState();
}

class _MatchingProcessScreenState extends State<MatchingProcessScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late final AnimationController _animationController;
  late final Animation<double> _progress;

  bool _apiCompleted = false;
  MatchingState? _apiResult;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _progress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    )..addListener(_onProgressChanged);
    _animationController.addStatusListener(_onAnimationStatus);
    _startMatching();
  }

  void _startMatching() {
    final cubit = sl<MatchingCubit>();
    cubit.fetchMatches();
    _animationController.forward();
  }

  void _onProgressChanged() {
    setState(() {});
  }

  void _onAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _navigationCheck();
    }
  }

  void _navigationCheck() {
    if (!_apiCompleted || !mounted) return;
    final state = _apiResult;
    if (state is MatchingLoaded) {
      if (state.data.recommendations.isNotEmpty) {
        context.goNamed(BridegeXRouteNames.recommendedTeams);
      } else {
        context.goNamed(BridegeXRouteNames.noTeamsFound);
      }
    } else {
      context.goNamed(BridegeXRouteNames.noTeamsFound);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final percentage = (_progress.value * 100).toInt();

    return BlocProvider.value(
      value: sl<MatchingCubit>(),
      child: BlocListener<MatchingCubit, MatchingState>(
        listener: (context, state) {
          if (state is MatchingLoaded || state is MatchingError) {
            _apiCompleted = true;
            _apiResult = state;
            _navigationCheck();
          }
        },
        child: ScrollNavListener(
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
                    MatchingProgressRing(
                      percentage: percentage.toDouble(),
                      label: AppStrings.optimizing,
                    ),
                    VerticalSpacing(AppSpacing.spacing32),
                    const DynamicInsightCard(),
                    VerticalSpacing(AppSpacing.spacing24),
                    SkillScanSection(progress: _progress.value),
                    VerticalSpacing(AppSpacing.spacing40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
