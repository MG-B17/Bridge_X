import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/team_managment/my_tasks/data/models/models/task_item.dart';
import 'package:bridge_x/features/team_managment/utils/task_strings.dart';
import 'package:flutter/material.dart';

class TaskDetailsHeaderCard extends StatelessWidget {
  const TaskDetailsHeaderCard({super.key, required this.task});

  final TaskItem task;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.spacing16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radius16),
        border: Border.all(color: context.colors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildTag(
                context,
                TaskStrings.inProgress.toUpperCase(),
                context.colors.primary,
                context.colors.primary.withValues(alpha: 0.1),
              ),
              HorizontalSpacing(AppSpacing.spacing4),
              _buildTag(
                context,
                TaskStrings.high.toUpperCase(),
                context.colors.error,
                context.colors.error.withValues(alpha: 0.1),
              ),
            ],
          ),
          VerticalSpacing(AppSpacing.spacing16),
          Text(
            task.project.toUpperCase(),
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colors.textSecondary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
          VerticalSpacing(AppSpacing.spacing4),
          Text(
            task.title,
            style: context.textTheme.headlineSmall?.copyWith(
              color: context.colors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(BuildContext context, String text, Color color, Color bgColor) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.spacing10,
        vertical: AppSpacing.spacing4,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppSpacing.radius32),
      ),
      child: Text(
        text,
        style: context.textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: AppSpacing.fontSize10,
        ),
      ),
    );
  }
}
