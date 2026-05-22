import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'completed_task_card.dart';
import 'task_card.dart';
import 'task_summary_cards.dart';

class CompletedTasksTab extends StatelessWidget {
  const CompletedTasksTab({
    super.key,
    required this.tasks,
  });

  final List<TaskItem> tasks;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TaskSummaryCards(
          totalDone: '124',
          thisWeek: '18',
        ),
        VerticalSpacing(AppSpacing.lg),

        // Recently Finished Badge Header
        Row(
          children: [
            Text(
              'Recently Finished',
              style: context.textTheme.titleMedium?.copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            HorizontalSpacing(AppSpacing.xs),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: context.colors.success.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
              ),
              child: Text(
                '${tasks.length} DONE',
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colors.success,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        VerticalSpacing(AppSpacing.md),

        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tasks.length,
          separatorBuilder: (context, index) => VerticalSpacing(AppSpacing.md),
          itemBuilder: (context, index) {
            final task = tasks[index];
            return CompletedTaskCard(
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
      ],
    );
  }
}
