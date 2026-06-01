import 'package:bridge_x/core/animation/bottom_nav_bar_animation/widget/scroller_listener.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_error_widget.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_skeletonizer.dart';
import 'package:bridge_x/feature/levels/domain/entities/level_entity.dart';
import 'package:bridge_x/feature/levels/presentation/controller/level_cubit.dart';
import 'package:bridge_x/feature/levels/presentation/controller/level_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/your_level_screen_widget/your_level_header.dart';
import '../widget/your_level_screen_widget/current_tier_card.dart';
import '../widget/your_level_screen_widget/level_stats_row.dart';
import '../widget/your_level_screen_widget/ai_consistency_banner.dart';
import '../widget/your_level_screen_widget/level_roadmap_section.dart';

class YourLevelScreen extends StatefulWidget {
  const YourLevelScreen({super.key});

  @override
  State<YourLevelScreen> createState() => _YourLevelScreenState();
}

class _YourLevelScreenState extends State<YourLevelScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LevelCubit>(
      create: (_) => sl<LevelCubit>()..fetchLevel(),
      child: Scaffold(
        backgroundColor: context.colors.scaffoldBg,
        body: SafeArea(
          child: BlocBuilder<LevelCubit, LevelState>(
            builder: (context, state) {
              if (state is LevelError) {
                return BridgeXErrorWidget(
                  errorTittle: 'Failed to Load Level',
                  errorMessage: state.message,
                  refreshButtonTap: () => context.read<LevelCubit>().fetchLevel(),
                );
              }

              final isLoading = state is LevelInitial || state is LevelLoading;
              final LevelEntity? level = state is LevelLoaded ? state.level : null;

              return BridgeXSkeletonizer(
                enableloading: isLoading,
                child: ScrollNavListener(
                  controller: _scrollController,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    padding: EdgeInsets.only(
                      left: AppSpacing.spacing20,
                      right: AppSpacing.spacing20,
                      top: AppSpacing.spacing16,
                      bottom: AppSpacing.spacing16 + AppSpacing.spacing20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const YourLevelHeader(),
                        VerticalSpacing(AppSpacing.spacing24),
                        CurrentTierCard(
                          currentLevelFull: level?.currentLevelFull,
                          progressPercentage: level?.progressPercentage,
                          nextLevelFull: level?.nextLevelFull,
                        ),
                        VerticalSpacing(AppSpacing.spacing20),
                        LevelStatsRow(
                          totalTasks: level?.totalTasks,
                          averageRating: level?.averageRating,
                        ),
                        VerticalSpacing(AppSpacing.spacing20),
                        const AiConsistencyBanner(),
                        VerticalSpacing(AppSpacing.spacing24),
                        LevelRoadmapSection(
                          baseLevel: level?.baseLevel,
                          subLevel: level?.subLevel,
                        ),
                        VerticalSpacing(AppSpacing.spacing32),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
