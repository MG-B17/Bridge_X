import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:bridge_x/feature/my_tasks/data/model/task_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class TaskAttachmentCard extends StatelessWidget {
  const TaskAttachmentCard({super.key, required this.attachment});

  final TaskAttachment attachment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        border: Border.all(color: context.colors.divider),
      ),
      child: Row(
        children: [
          // Icon Box
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: attachment.isPdf
                  ? context.colors.error.withValues(alpha: 0.1)
                  : context.colors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
            ),
            child: Icon(
              attachment.isPdf ? Icons.picture_as_pdf : Icons.image_outlined,
              color: attachment.isPdf ? context.colors.error : context.colors.primary,
              size: 24.sp,
            ),
          ),
          HorizontalSpacing(AppSpacing.md),

          // Title / Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attachment.name,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                VerticalSpacing(AppSpacing.xs),
                Text(
                  '${attachment.size} • Added ${attachment.dateAdded}',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Download Action
          IconButton(
            icon: Icon(
              Icons.download_outlined,
              color: context.colors.textSecondary,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
