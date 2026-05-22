import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'empty_tasks_state.dart';
import 'task_card.dart';

class ActiveTasksTab extends StatelessWidget {
  const ActiveTasksTab({
    super.key,
    required this.tasks,
    required this.onSimulateEmptyTap,
  });

  final List<TaskItem> tasks;
  final VoidCallback onSimulateEmptyTap;

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return EmptyTasksState(
        onExploreTap: () {
          // Go to projects search
        },
      );
    }

    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tasks.length,
          separatorBuilder: (context, index) => VerticalSpacing(AppSpacing.md),
          itemBuilder: (context, index) {
            final task = tasks[index];
            return TaskCard(
              task: task,
              onTap: () {
                context.goNamed(
                  BridegeXRouteNames.myTasksDetails,
                  extra: task,
                );
              },
            );
          },
        ),
        VerticalSpacing(AppSpacing.xl),
        Center(
          child: TextButton(
            onPressed: onSimulateEmptyTap,
            child: Text(
              'Simulate Empty State',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colors.textSecondary.withValues(alpha: 0.6),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
