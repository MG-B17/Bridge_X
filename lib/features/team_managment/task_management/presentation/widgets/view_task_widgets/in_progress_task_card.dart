import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_shadow.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/team_managment/task_management/domain/entities/task_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'priority_badge.dart';

class InProgressTaskCard extends StatelessWidget {
  const InProgressTaskCard({super.key, required this.task});

  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
        border: Border.all(color: colors.divider.withValues(alpha: 0.3)),
        boxShadow: AppShadow.subtle,
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
              Text('Progress', style: AppTextStyles.labelSmall.copyWith(color: colors.textSecondary)),
              const Spacer(),
              Text('${task.percentageTimePassed.toInt()}%', style: AppTextStyles.titleMedium.copyWith(color: colors.textPrimary, fontWeight: FontWeight.w700)),
            ],
          ),
          VerticalSpacing(AppSpacing.spacing6),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radius6),
            child: LinearProgressIndicator(
              value: task.percentageTimePassed / 100.0,
              minHeight: 6.h,
              backgroundColor: colors.divider.withValues(alpha: 0.3),
              valueColor: AlwaysStoppedAnimation(colors.primary),
            ),
          ),
          VerticalSpacing(AppSpacing.spacing12),
          Row(
            children: [
              Icon(Icons.access_time_rounded, size: 14.sp, color: task.isOverdue ? colors.error : colors.textHint),
              HorizontalSpacing(AppSpacing.spacing4),
              Text(task.deadline.toShortDate(), style: AppTextStyles.labelSmall.copyWith(color: task.isOverdue ? colors.error : colors.textSecondary)),
              const Spacer(),
              if (task.isOverdue)
                Text('Overdue', style: AppTextStyles.labelSmall.copyWith(color: colors.error, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}

