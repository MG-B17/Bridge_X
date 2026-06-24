import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_names.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/team_managment/utils/task_strings.dart';
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
    required this.totalDone,
    required this.thisWeek,
  });

  final List<TaskItem> tasks;
  final String totalDone;
  final String thisWeek;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TaskSummaryCards(
          totalDone: totalDone,
          thisWeek: thisWeek,
        ),
        VerticalSpacing(AppSpacing.lg),

        // Recently Finished Badge Header
        Row(
          children: [
            Text(
              TaskStrings.recentlyFinished,
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

        for (final task in tasks) ...[
          CompletedTaskCard(
            task: task,
            onTap: () {
              context.goNamed(
                BridgeXRouteNames.myTasksDetails,
                extra: task,
              );
            },
          ),
          VerticalSpacing(AppSpacing.md),
        ],
      ],
    );
  }
}
