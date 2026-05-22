import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:bridge_x/feature/my_tasks/data/model/task_model.dart';
export 'package:bridge_x/feature/my_tasks/data/model/task_model.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
  });

  final TaskItem task;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    Color statusBgColor;
    String statusText;

    switch (task.status) {
      case TaskStatus.inProgress:
        statusColor = context.colors.primary;
        statusBgColor = context.colors.primary.withValues(alpha: 0.1);
        statusText = 'IN PROGRESS';
        break;
      case TaskStatus.pending:
        statusColor = context.colors.warning;
        statusBgColor = context.colors.warning.withValues(alpha: 0.1);
        statusText = 'PENDING';
        break;
      case TaskStatus.nearCompletion:
        statusColor = context.colors.success;
        statusBgColor = context.colors.success.withValues(alpha: 0.1);
        statusText = 'NEAR COMPLETION';
        break;
      case TaskStatus.completed:
        statusColor = context.colors.success;
        statusBgColor = context.colors.success.withValues(alpha: 0.1);
        statusText = 'COMPLETED';
        break;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
          border: Border.all(color: context.colors.divider),
          boxShadow: [
            BoxShadow(
              color: context.colors.textPrimary.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Project Label & Status Tag ──
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  task.project.toUpperCase(),
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.colors.textSecondary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                  ),
                  child: Text(
                    statusText,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            VerticalSpacing(AppSpacing.xs),

            // ── Title ──
            Text(
              task.title,
              style: context.textTheme.titleMedium?.copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            VerticalSpacing(AppSpacing.md),

            // ── Progress Bar ──
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.progress,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.textSecondary,
                  ),
                ),
                Text(
                  '${(task.progress * 100).toInt()}%',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            VerticalSpacing(AppSpacing.xs),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
              child: LinearProgressIndicator(
                value: task.progress,
                color: statusColor,
                backgroundColor: context.colors.divider.withValues(alpha: 0.5),
                minHeight: 8.h,
              ),
            ),
            VerticalSpacing(AppSpacing.md),

            // ── Divider ──
            Container(
              height: 1.h,
              color: context.colors.divider,
            ),
            VerticalSpacing(AppSpacing.md),

            // ── Due Date ──
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: context.colors.textSecondary,
                  size: 16.sp,
                ),
                HorizontalSpacing(AppSpacing.xs),
                Text(
                  '${AppStrings.dueDate} ${task.dueDate}',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
