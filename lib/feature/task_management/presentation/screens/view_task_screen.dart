import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_error_widget.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_refresh_indicator.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_skeletonizer.dart';
import 'package:bridge_x/feature/task_management/domain/entities/view_task_entity.dart';
import 'package:bridge_x/feature/task_management/presentation/bloc/view_task/view_task_cubit.dart';
import 'package:bridge_x/feature/task_management/presentation/bloc/view_task/view_task_state.dart';
import 'package:bridge_x/feature/task_management/presentation/widgets/view_task_widgets/completed_task_card.dart';
import 'package:bridge_x/feature/task_management/presentation/widgets/view_task_widgets/in_progress_task_card.dart';
import 'package:bridge_x/feature/task_management/presentation/widgets/view_task_widgets/task_section_header.dart';
import 'package:bridge_x/feature/task_management/presentation/widgets/view_task_widgets/todo_task_card.dart';
import 'package:bridge_x/feature/task_management/presentation/widgets/view_task_widgets/view_task_project_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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

            final isLoading = state is ViewTaskInitial || state is ViewTaskLoading;
            final isRefreshing = state is ViewTaskRefreshing;
            final showSkeleton = isLoading || isRefreshing;
            final data = _resolveData(state);

            return BridgeXSkeletonizer(
              enableloading: showSkeleton,
              child: BridgeXRefreshIndicator(
                color: isRefreshing ? colors.transparent : colors.primary,
                backgroundColor: isRefreshing ? colors.transparent : null,
                onRefresh: () async => context.read<ViewTaskCubit>().refresh(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing20, vertical: AppSpacing.spacing16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(context, data),
                      VerticalSpacing(AppSpacing.spacing16),
                      ViewTaskProjectCard(teamName: data.teamName, myTrack: data.myTrack),
                      VerticalSpacing(AppSpacing.spacing24),
                      _buildTaskSections(data),
                      VerticalSpacing(AppSpacing.spacing32),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  ViewTaskEntity _resolveData(ViewTaskState state) => switch (state) {
        ViewTaskLoaded(:final data) => data,
        ViewTaskRefreshing(:final data) => data,
        _ => const ViewTaskEntity(teamId: 0, teamName: '', projectDescription: '', myTrack: '', members: [], tasksView: 'my', tasks: []),
      };

  Widget _buildHeader(BuildContext context, ViewTaskEntity data) {
    final colors = context.colors;
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          child: Icon(Icons.arrow_back, color: colors.textPrimary, size: 24.sp),
        ),
        SizedBox(width: AppSpacing.spacing12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Project Tasks', style: AppTextStyles.headlineSmall.copyWith(color: colors.textPrimary, fontWeight: FontWeight.w700)),
              Text('Tasks assigned inside ${data.teamName}', maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.labelSmall.copyWith(color: colors.textSecondary)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTaskSections(ViewTaskEntity data) {
    final inProgress = data.inProgressTasks;
    final todo = data.todoTasks;
    final completed = data.completedTasks;
    final firstMember = data.members.isNotEmpty ? data.members.first.name : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (inProgress.isNotEmpty) ...[
          TaskSectionHeader(title: 'In Progress', count: inProgress.length),
          VerticalSpacing(AppSpacing.spacing12),
          ...inProgress.map((t) => Padding(padding: EdgeInsets.only(bottom: AppSpacing.spacing12), child: InProgressTaskCard(task: t, assignedName: firstMember))),
        ],
        if (todo.isNotEmpty) ...[
          VerticalSpacing(AppSpacing.spacing8),
          TaskSectionHeader(title: 'To Do', count: todo.length),
          VerticalSpacing(AppSpacing.spacing12),
          ...todo.map((t) => Padding(padding: EdgeInsets.only(bottom: AppSpacing.spacing12), child: TodoTaskCard(task: t, assignedName: firstMember))),
        ],
        if (completed.isNotEmpty) ...[
          VerticalSpacing(AppSpacing.spacing8),
          TaskSectionHeader(title: 'Completed', count: completed.length),
          VerticalSpacing(AppSpacing.spacing12),
          ...completed.map((t) => Padding(padding: EdgeInsets.only(bottom: AppSpacing.spacing12), child: CompletedTaskCard(task: t))),
        ],
      ],
    );
  }
}
