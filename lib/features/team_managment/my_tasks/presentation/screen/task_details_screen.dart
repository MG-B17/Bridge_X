import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_back_button.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_refresh_indicator.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_error_widget.dart';
import 'package:bridge_x/features/team_managment/my_tasks/presentation/cubit/my_tasks_cubit.dart';
import 'package:bridge_x/features/team_managment/my_tasks/presentation/cubit/my_tasks_state.dart';
import 'package:bridge_x/features/team_managment/utils/task_strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/models/task_item.dart';
import '../widget/task_details_widget/task_details_content.dart';
import '../widget/task_details_widget/task_details_skeleton.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key, this.task, this.taskId});

  final TaskItem? task;
  final int? taskId;

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.taskId != null) {
      context.read<MyTasksCubit>().fetchTaskDetails(widget.taskId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  const BridgeXBackButton(),
                  const Spacer(),
                  Text(
                    TaskStrings.taskDetails,
                    style: context.textTheme.titleLarge?.copyWith(
                      color: context.colors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  HorizontalSpacing(40.w),
                ],
              ),
            ),

            Expanded(
              child: BlocBuilder<MyTasksCubit, MyTasksState>(
                builder: (context, state) {
                  final hasLocalTask = widget.task != null;

                  if (widget.taskId != null) {
                    if (state is TaskDetailsLoading && !hasLocalTask) {
                      return _buildLoadingView();
                    }
                    if (state is TaskDetailsLoaded) {
                      return _buildLoadedView(state.task);
                    }
                    if (state is TaskDetailsFailure && !hasLocalTask) {
                      return BridgeXErrorWidget(
                        errorTittle: 'Error',
                        errorMessage: state.message,
                        refreshButtonTap: () =>
                            context.read<MyTasksCubit>().fetchTaskDetails(widget.taskId!),
                      );
                    }
                  }

                  final task = widget.task;
                  if (task != null) {
                    return _buildLoadedView(task);
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingView() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: const TaskDetailsSkeleton(),
    );
  }

  Widget _buildLoadedView(TaskItem task) {
    return BridgeXRefreshIndicator(
      color: context.colors.primary,
      onRefresh: () async {
        if (widget.taskId != null) {
          await context.read<MyTasksCubit>().fetchTaskDetails(widget.taskId!);
        }
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: TaskDetailsContent(task: task),
      ),
    );
  }

}
