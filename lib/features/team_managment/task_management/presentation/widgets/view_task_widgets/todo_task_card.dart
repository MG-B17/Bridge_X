import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/team_managment/task_management/domain/entities/task_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'priority_badge.dart';

class TodoTaskCard extends StatelessWidget {
  const TodoTaskCard({super.key, required this.task});

  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colors.completedBg.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
        border: Border.all(color: colors.divider.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(task.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: AppTextStyles.titleLarge.copyWith(color: colors.textPrimary, fontWeight: FontWeight.w700)),
              ),
              HorizontalSpacing(AppSpacing.spacing8),
              PriorityBadge(priority: task.priority),
            ],
          ),
          VerticalSpacing(AppSpacing.spacing12),
          Row(
            children: [
              Icon(Icons.access_time_rounded, size: 14.sp, color: task.isOverdue ? colors.error : colors.textHint),
              HorizontalSpacing(AppSpacing.spacing4),
              Text(task.deadline.toShortDate(), style: AppTextStyles.labelSmall.copyWith(color: task.isOverdue ? colors.error : colors.textSecondary)),
            ],
          ),
        ],
      ),
    );
  }
}

