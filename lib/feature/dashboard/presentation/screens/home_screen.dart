import 'package:bridge_x/core/animation/bottom_nav_bar_animation/widget/scroller_listener.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/extensions.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_error_widget.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_refresh_indicator.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_skeletonizer.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_tip_banner.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/dashboard/domain/entities/dashboard_entity.dart';
import 'package:bridge_x/feature/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:bridge_x/core/widget/feedback/error_dialog.dart';
import 'package:bridge_x/feature/dashboard/presentation/cubit/dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/home_header_widgets/greeting_header.dart';
import '../widgets/home_insight_widgets/ai_insights_card.dart';
import '../widgets/home_insight_widgets/team_action_buttons.dart';
import '../widgets/home_stats_widgets/productivity_section.dart';
import '../widgets/home_stats_widgets/project_bars_card.dart';
import '../widgets/home_stats_widgets/stats_row.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardCubit>(
      create: (context) => sl<DashboardCubit>()..loadDashboard(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<DashboardCubit, DashboardState>(
            listener: (context, state) {
              if (state is DashboardLoaded && state.errorMessage != null) {
                ErrorDialog.show(context: context, title: 'Error', message: state.errorMessage!);
              }
            },
            builder: (context, state) {
              if (state is DashboardError) {
                return BridgeXErrorWidget(
                  errorMessage: state.message,
                  errorTittle: 'Failed to Load Dashboard',
                  refreshButtonTap: () => context.read<DashboardCubit>().loadDashboard(),
                );
              }

              final isLoading = state is DashboardInitial || state is DashboardLoading;
              final isRefreshing = state is DashboardRefreshing;

              final DashboardEntity? dashboard = state is DashboardLoaded
                  ? state.dashboard
                  : (state is DashboardRefreshing ? state.dashboard : null);

              return BridgeXRefreshIndicator(
                onRefresh: () async {
                  context.read<DashboardCubit>().loadDashboard(isRefresh: true);
                },
                color: isRefreshing ? context.appColors.transparent : context.appColors.primary,
                backgroundColor: isRefreshing ? context.appColors.transparent : null,
                child: ScrollNavListener(
                  controller: _scrollController,
                  child: BridgeXSkeletonizer(
                    enableloading: isLoading || isRefreshing,
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
                          GreetingHeader(programmerName: dashboard?.programmerName),
                          VerticalSpacing(AppSpacing.spacing16),
                          (dashboard?.projectsDetails.isEmpty ?? false)
                              ? const BridgeXTipBanner(message: AppStrings.tipBanner)
                              : const SizedBox.shrink(),
                          VerticalSpacing(AppSpacing.spacing16),
                          const TeamActionButtons(),
                          VerticalSpacing(AppSpacing.spacing24),
                          StatsRow(
                            totalTasks: dashboard?.totalTasksAllProjects,
                            completedTasks: dashboard?.completedTasksAllProjects,
                            projectsCount: dashboard?.totalProjectsParticipated,
                          ),
                          VerticalSpacing(AppSpacing.spacing24),
                          ProductivitySection(completionRate: dashboard?.overallCompletionRate),
                          VerticalSpacing(AppSpacing.spacing16),
                          ProjectBarsCard(projects: dashboard?.projectsDetails),
                          VerticalSpacing(AppSpacing.spacing16),
                          const AiInsightsCard(),
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
