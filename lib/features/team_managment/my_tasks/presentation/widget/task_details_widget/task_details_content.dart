import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_button.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/team_managment/my_tasks/data/models/models/task_item.dart';
import 'package:bridge_x/features/team_managment/utils/task_strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import 'task_attachment_card.dart';
import 'task_detail_field.dart';
import 'task_details_header_card.dart';

class TaskDetailsContent extends StatelessWidget {
  const TaskDetailsContent({super.key, required this.task});

  final TaskItem task;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TaskDetailsHeaderCard(task: task),
        VerticalSpacing(AppSpacing.lg),
        TaskDetailField(
          label: TaskStrings.description,
          child: Text(
            task.description,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colors.textSecondary,
              height: 1.5,
            ),
          ),
        ),
        VerticalSpacing(AppSpacing.lg),
        TaskDetailField(
          label: TaskStrings.dueDate,
          child: Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                color: context.colors.primary,
                size: 20.sp,
              ),
              HorizontalSpacing(AppSpacing.sm),
              Text(
                task.dueDate,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        VerticalSpacing(AppSpacing.lg),
        TaskDetailField(
          label: task.assignedTo.isNotEmpty
              ? TaskStrings.assignedTo
              : TaskStrings.createdBy,
          child: Row(
            children: [
              CircleAvatar(
                radius: 16.r,
                backgroundImage: _avatarUrl(task).isNotEmpty
                    ? NetworkImage(_avatarUrl(task))
                    : null,
                child: _avatarUrl(task).isEmpty
                    ? const Icon(Icons.person)
                    : null,
              ),
              HorizontalSpacing(AppSpacing.sm),
              Text(
                task.assignedTo.isNotEmpty ? task.assignedTo : task.createdBy,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        VerticalSpacing(AppSpacing.lg),
        if (task.gitLink != null && task.gitLink!.isNotEmpty) ...[
          TaskDetailField(
            label: TaskStrings.gitLink,
            child: Text(
              task.gitLink!,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          VerticalSpacing(AppSpacing.lg),
        ],
        if (task.tags.isNotEmpty) ...[
          TaskDetailField(
            label: TaskStrings.tags,
            child: Wrap(
              spacing: AppSpacing.spacing8,
              runSpacing: AppSpacing.spacing8,
              children: task.tags
                  .map(
                    (tag) => Chip(
                      label: Text(tag),
                      backgroundColor:
                          context.colors.primary.withValues(alpha: 0.08),
                      side: BorderSide(color: context.colors.divider),
                    ),
                  )
                  .toList(),
            ),
          ),
          VerticalSpacing(AppSpacing.lg),
        ],
        if (task.attachments.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
            child: Text(
              TaskStrings.attachments.toUpperCase(),
              style: context.textTheme.labelSmall?.copyWith(
                color: context.colors.textSecondary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
          ),
          for (final attachment in task.attachments) ...[
            TaskAttachmentCard(attachment: attachment),
            VerticalSpacing(AppSpacing.sm),
          ],
          VerticalSpacing(AppSpacing.xl),
        ],
        BridgeXButton(
          text: TaskStrings.updateProgress,
          onTap: () { 
            Navigator.of(context).pop();
          },
        ),
        VerticalSpacing(AppSpacing.xl),
      ],
    );
  }

  String _avatarUrl(TaskItem task) {
    return task.assignedAvatar.isNotEmpty
        ? task.assignedAvatar
        : task.creatorAvatar;
  }
}
