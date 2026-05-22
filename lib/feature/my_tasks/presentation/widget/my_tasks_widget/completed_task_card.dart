import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/theme/bridge_x_colors.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
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
          horizontal: AppSpacing.spacing16,
          vertical: AppSpacing.spacing8,
        ),
        decoration: BoxDecoration(
          color: context.colors.completedBg,
          borderRadius: BorderRadius.circular(AppSpacing.radius12),
          border: Border.all(color: context.colors.completedBg),
        ),
        child: Row(
          children: [
            // ── Green Check Icon ──
            Container(
              padding: EdgeInsets.all(AppSpacing.radius6),
              decoration: BoxDecoration(
                color: context.colors.success,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check,
                color: AppColors.white,
                size: AppSpacing.spacing16,
              ),
            ),
            HorizontalSpacing(AppSpacing.spacing16),

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
                  VerticalSpacing(AppSpacing.spacing4),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        color: context.colors.textSecondary,
                        size: AppSpacing.fontSize12,
                      ),
                      HorizontalSpacing(AppSpacing.spacing4),
                      Text(
                        '${AppStrings.completed} ${task.dueDate}',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: context.colors.textSecondary,
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
