import 'package:bridge_x/core/animation/bottom_nav_bar_animation/widget/scroller_listener.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_error_widget.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_refresh_indicator.dart';
import 'package:bridge_x/features/team_managment/my_tasks/presentation/cubit/my_tasks_cubit.dart';
import 'package:bridge_x/features/team_managment/my_tasks/presentation/cubit/my_tasks_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/my_tasks_widget/active_tasks_skeleton.dart';
import '../widget/my_tasks_widget/active_tasks_tab.dart';
import '../widget/my_tasks_widget/completed_tasks_skeleton.dart';
import '../widget/my_tasks_widget/completed_tasks_tab.dart';
import '../widget/my_tasks_widget/my_tasks_header.dart';
import '../widget/my_tasks_widget/my_tasks_tab_selector.dart';

class MyTasksScreen extends StatefulWidget {
  const MyTasksScreen({super.key});

  @override
  State<MyTasksScreen> createState() => _MyTasksScreenState();
}

class _MyTasksScreenState extends State<MyTasksScreen> {
  bool _isActiveTab = true;
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
        backgroundColor: context.colors.scaffoldBg,
        body: SafeArea(
          child: BlocConsumer<MyTasksCubit, MyTasksState>(
            listener: (context, state) {
              if (state is MyTasksLoaded &&
                  state.partialFailureMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.partialFailureMessage!),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            builder: (context, state) {
              return BridgeXRefreshIndicator(
                color: context.colors.primary,
                onRefresh: () => context.read<MyTasksCubit>().fetchAllTasks(),
                child: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    const SliverToBoxAdapter(child: MyTasksHeader()),
                    SliverAppBar(
                      pinned: true,
                      primary: false,
                      automaticallyImplyLeading: false,
                      backgroundColor: context.colors.scaffoldBg,
                      surfaceTintColor: Colors.transparent,
                      toolbarHeight: AppSpacing.spacing20 + 44,
                      titleSpacing: 0,
                      title: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.spacing20,
                        ),
                        child: MyTasksTabSelector(
                          isActiveTab: _isActiveTab,
                          onTabChanged: (val) {
                            setState(() => _isActiveTab = val);
                          },
                        ),
                      ),
                    ),
                  ],
                  body: CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.only(
                          left: AppSpacing.spacing20,
                          right: AppSpacing.spacing20,
                          top: AppSpacing.spacing16,
                          bottom: AppSpacing.spacing20,
                        ),
                        sliver: SliverToBoxAdapter(child: _buildContent(state)),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(MyTasksState state) {
    if (state is MyTasksLoading) {
      return _isActiveTab
          ? const ActiveTasksSkeleton()
          : const CompletedTasksSkeleton();
    }

    if (state is MyTasksFailure) {
      return BridgeXErrorWidget(
        errorTittle: 'Error',
        errorMessage: state.message,
        refreshButtonTap: () => context.read<MyTasksCubit>().fetchAllTasks(),
      );
    }

    if (state is MyTasksLoaded) {
      if (_isActiveTab) {
        return ActiveTasksTab(tasks: state.activeTasks);
      } else {
        return CompletedTasksTab(
          tasks: state.completedTasks,
          totalDone: state.numOfTasksDone.toString(),
          thisWeek: state.numOfTasksDoneThisWeek.toString(),
        );
      }
    }

    return const SizedBox.shrink();
  }
}
