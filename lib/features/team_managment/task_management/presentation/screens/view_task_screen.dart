import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_error_widget.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_refresh_indicator.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_skeletonizer.dart';
import 'package:bridge_x/features/team_managment/task_management/domain/entities/view_task_entity.dart';
import 'package:bridge_x/features/team_managment/task_management/presentation/bloc/view_task/view_task_cubit.dart';
import 'package:bridge_x/features/team_managment/task_management/presentation/bloc/view_task/view_task_state.dart';
import 'package:bridge_x/features/team_managment/task_management/presentation/widgets/view_task_widgets/view_task_body.dart';
import 'package:bridge_x/features/team_managment/task_management/presentation/widgets/view_task_widgets/view_task_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewTaskScreen extends StatelessWidget {
  const ViewTaskScreen({super.key, required this.projectId});

  final int projectId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ViewTaskCubit>(
      create: (_) => sl<ViewTaskCubit>()..loadTasks(projectId),
      child: const _ViewTaskContent(),
    );
  }
}

class _ViewTaskContent extends StatelessWidget {
  const _ViewTaskContent();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      body: SafeArea(
        child: BlocListener<ViewTaskCubit, ViewTaskState>(
          listenWhen: (previous, current) =>
              current is ViewTaskLoaded && current.refreshError != null,
          listener: (context, state) {
            if (state is ViewTaskLoaded && state.refreshError != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.refreshError!),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          child: BlocBuilder<ViewTaskCubit, ViewTaskState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              if (state is ViewTaskError) {
                return BridgeXErrorWidget(
                  errorTittle: AppStrings.error,
                  errorMessage: state.message,
                  refreshButtonTap: () => context.read<ViewTaskCubit>().retry(),
                );
              }

              final isLoading =
                  state is ViewTaskInitial || state is ViewTaskLoading;
              final data = switch (state) {
                ViewTaskLoaded(:final data) => data,
                ViewTaskRefreshing(:final data) => data,
                _ => const ViewTaskEntity(activeTasks: [], completedTasks: [], inProgressTasks: [], todoTasks: []),
              };

              return BridgeXSkeletonizer(
                enableloading: isLoading,
                child: BridgeXRefreshIndicator(
                  color: colors.primary,
                  onRefresh: () async =>
                      context.read<ViewTaskCubit>().refresh(),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.spacing20,
                      vertical: AppSpacing.spacing16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ViewTaskHeader(data: data),
                        VerticalSpacing(AppSpacing.spacing16),
                        ViewTaskBody(data: data),
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
