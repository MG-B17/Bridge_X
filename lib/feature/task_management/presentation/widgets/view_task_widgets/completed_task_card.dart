import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/task_management/domain/entities/task_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompletedTaskCard extends StatelessWidget {
  const CompletedTaskCard({super.key, required this.task});

  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colors.completedBg.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
        border: Border.all(color: colors.completedText.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(task.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: AppTextStyles.titleLarge.copyWith(color: colors.textPrimary, fontWeight: FontWeight.w600)),
              ),
              Icon(Icons.check_circle, color: colors.completedText, size: 22.sp),
            ],
          ),
          VerticalSpacing(AppSpacing.spacing6),
          Row(
            children: [
              Icon(Icons.access_time_rounded, size: 14.sp, color: colors.textSecondary),
              HorizontalSpacing(AppSpacing.spacing4),
              Text('Finished ${_formatDate(task.dueDate)}', style: AppTextStyles.labelSmall.copyWith(color: colors.textSecondary)),
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
