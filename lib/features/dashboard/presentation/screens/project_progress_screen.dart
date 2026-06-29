import 'package:bridge_x/core/animation/bottom_nav_bar_animation/controller/scroll_cubit.dart';
import 'package:bridge_x/core/animation/bottom_nav_bar_animation/widget/scroller_listener.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_back_button.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/dashboard/domain/entities/project_detail_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../widgets/project_progress_widgets/focus_impact_banner.dart';
import '../widgets/project_progress_widgets/project_progress_card.dart';
import '../widgets/project_progress_widgets/project_progress_header.dart';

class ProjectProgressScreen extends StatefulWidget {
  const ProjectProgressScreen({super.key, this.projects});

  final List<ProjectDetailEntity>? projects;

  @override
  State<ProjectProgressScreen> createState() => _ProjectProgressScreenState();
}

class _ProjectProgressScreenState extends State<ProjectProgressScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
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
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.spacing20,
              vertical: AppSpacing.spacing12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: BridgeXBackButton(
                    onTap: () {
                      context.read<ScrollCubit>().show();
                      context.pop();
                    },
                  ),
                ),
                VerticalSpacing(AppSpacing.spacing16),
                const ProjectProgressHeader(),
                VerticalSpacing(AppSpacing.spacing24),
                if (widget.projects != null && widget.projects!.isNotEmpty)
                  ProjectProgressCard(projects: widget.projects!),
                VerticalSpacing(AppSpacing.spacing24),
                const FocusImpactBanner(),
                VerticalSpacing(AppSpacing.spacing20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
