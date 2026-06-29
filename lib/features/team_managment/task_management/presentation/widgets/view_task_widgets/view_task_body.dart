import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/team_managment/task_management/domain/entities/view_task_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import 'completed_task_card.dart';
import 'in_progress_task_card.dart';
import 'task_section_header.dart';
import 'todo_task_card.dart';

class ViewTaskBody extends StatelessWidget {
  const ViewTaskBody({super.key, required this.data});

  final ViewTaskEntity data;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final inProgress = data.inProgressTasks;
    final todo = data.todoTasks;
    final completed = data.completedTasks;
    final hasAnyTask =
        inProgress.isNotEmpty || todo.isNotEmpty || completed.isNotEmpty;

    if (!hasAnyTask) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 48.h),
          child: Column(
            children: [
              Icon(
                Icons.task_alt,
                size: 64.sp,
                color: colors.textSecondary.withValues(alpha: 0.4),
              ),
              VerticalSpacing(AppSpacing.spacing16),
              Text(
                'No tasks yet',
                style: AppTextStyles.titleLarge.copyWith(
                  color: colors.textSecondary,
                ),
              ),
              VerticalSpacing(AppSpacing.spacing8),
              Text(
                'Tasks assigned to this project will appear here',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: colors.textHint,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (inProgress.isNotEmpty) ...[
          TaskSectionHeader(title: 'In Progress', count: inProgress.length),
          VerticalSpacing(AppSpacing.spacing12),
          ...inProgress.map(
            (t) => Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.spacing12),
              child: InProgressTaskCard(task: t),
            ),
          ),
        ],
        if (todo.isNotEmpty) ...[
          VerticalSpacing(AppSpacing.spacing8),
          TaskSectionHeader(title: 'To Do', count: todo.length),
          VerticalSpacing(AppSpacing.spacing12),
          ...todo.map(
            (t) => Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.spacing12),
              child: TodoTaskCard(task: t),
            ),
          ),
        ],
        if (completed.isNotEmpty) ...[
          VerticalSpacing(AppSpacing.spacing8),
          TaskSectionHeader(title: 'Completed', count: completed.length),
          VerticalSpacing(AppSpacing.spacing12),
          ...completed.map(
            (t) => Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.spacing12),
              child: CompletedTaskCard(task: t),
            ),
          ),
        ],
      ],
    );
  }
}
