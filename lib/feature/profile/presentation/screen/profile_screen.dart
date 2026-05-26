import 'package:bridge_x/core/animation/bottom_nav_bar_animation/widget/scroller_listener.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/extensions.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_error_widget.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_refresh_indicator.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_skeletonizer.dart';
import 'package:bridge_x/feature/profile/domain/entities/profile_dashboard_entity.dart';
import 'package:bridge_x/feature/profile/presentation/controller/profile_dashboard_cubit.dart';
import 'package:bridge_x/feature/profile/presentation/controller/profile_dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widget/profile_screen_widget/profile_header.dart';
import '../widget/profile_screen_widget/profile_stats.dart';
import '../widget/profile_screen_widget/profile_menu.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileDashboardCubit>(
      create: (_) => sl<ProfileDashboardCubit>()..fetchProfileDashboard(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<ProfileDashboardCubit, ProfileDashboardState>(
            builder: (context, state) {
              if (state is ProfileDashboardError) {
                return BridgeXErrorWidget(
                  errorTittle: 'Failed to Load Profile',
                  errorMessage: state.message,
                  refreshButtonTap: () => context.read<ProfileDashboardCubit>().fetchProfileDashboard(),
                );
              }

              final isLoading = state is ProfileDashboardInitial || state is ProfileDashboardLoading;
              final ProfileDashboardEntity? dashboard =
                  state is ProfileDashboardLoaded ? state.dashboard : null;

              return BridgeXRefreshIndicator(
                onRefresh: () async {
                  context.read<ProfileDashboardCubit>().fetchProfileDashboard();
                },
                color: context.appColors.primary,
                child: ScrollNavListener(
                  controller: _scrollController,
                  child: BridgeXSkeletonizer(
                    enableloading: isLoading,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      padding: EdgeInsets.only(
                        left: AppSpacing.spacing20,
                        right: AppSpacing.spacing20,
                        top: AppSpacing.spacing20,
                        bottom: AppSpacing.spacing20 + AppSpacing.spacing20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProfileHeader(profile: dashboard?.profile),
                          VerticalSpacing(AppSpacing.spacing24),
                          ProfileStats(
                            completedTasks: dashboard?.tasksStatistics.completedTasks,
                            teamsCount: dashboard?.teamsCount,
                            inProgressTasks: dashboard?.tasksStatistics.inProgressTasks,
                          ),
                          VerticalSpacing(AppSpacing.spacing24),
                          const ProfileMenu(),
                        ],
                      ),
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
