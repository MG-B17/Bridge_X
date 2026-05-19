import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'task_card.dart';

class CompletedTaskCard extends StatelessWidget {
  const CompletedTaskCard({
    super.key,
    required this.task,
    required this.onTap,
  });

  final TaskItem task;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: context.colors.completedBg,
          borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
          border: Border.all(color: context.colors.completedBg),
        ),
        child: Row(
          children: [
            // ── Green Check Icon ──
            Container(
              padding: EdgeInsets.all(6.r),
              decoration: BoxDecoration(
                color: context.colors.success,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 16.sp,
              ),
            ),
            HorizontalSpacing(AppSpacing.md),

            // ── Details ──
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.colors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  VerticalSpacing(AppSpacing.xs),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        color: context.colors.textSecondary,
                        size: 12.sp,
                      ),
                      HorizontalSpacing(4),
                      Text(
                        'Completed ${task.dueDate}',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colors.textSecondary,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── Options Button ──
            IconButton(
              icon: Icon(
                Icons.more_vert,
                color: context.colors.textSecondary,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
