import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/view_task/domain/entities/task_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TodoTaskCard extends StatelessWidget {
  const TodoTaskCard({super.key, required this.task, this.assignedName});

  final TaskEntity task;
  final String? assignedName;

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
              _PriorityBadge(priority: task.priority),
            ],
          ),
          VerticalSpacing(AppSpacing.spacing8),
          Text(task.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: AppTextStyles.bodyMedium.copyWith(color: colors.textSecondary, height: 1.4)),
          VerticalSpacing(AppSpacing.spacing12),
          Row(
            children: [
              Icon(Icons.person_outline, size: 14.sp, color: colors.textHint),
              HorizontalSpacing(AppSpacing.spacing4),
              Expanded(
                child: Text('By ${assignedName ?? ''}', maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.labelSmall.copyWith(color: colors.textSecondary)),
              ),
              Text(_formatDate(task.dueDate), style: AppTextStyles.labelSmall.copyWith(color: colors.textSecondary)),
              HorizontalSpacing(AppSpacing.spacing6),
              Icon(Icons.code, size: 14.sp, color: colors.textHint),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(String date) {
    if (date.isEmpty) return '';
    try {
      final parsed = DateTime.parse(date);
      const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      return '${months[parsed.month - 1]} ${parsed.day}';
    } catch (_) {
      return date;
    }
  }
}

class _PriorityBadge extends StatelessWidget {
  const _PriorityBadge({required this.priority});

  final int priority;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final (label, color) = switch (priority) {
      1 => ('High', colors.error),
      2 => ('Medium', colors.gold),
      _ => ('Low', colors.success),
    };
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing10, vertical: AppSpacing.spacing4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
      ),
      child: Text(label, style: AppTextStyles.labelSmall.copyWith(color: color, fontWeight: FontWeight.w600)),
    );
  }
}
