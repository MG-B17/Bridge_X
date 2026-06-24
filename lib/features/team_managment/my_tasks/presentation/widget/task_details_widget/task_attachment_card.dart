import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/team_managment/my_tasks/data/models/models/task_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  '${attachment.size} \u2022 Added ${attachment.dateAdded}',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              final url = attachment.url;
              if (url.isEmpty) return;
              final uri = Uri.tryParse(url);
              if (uri == null || !await canLaunchUrl(uri)) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Could not open $url')),
                  );
                }
                return;
              }
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            },
            child: Icon(
              Icons.download_outlined,
              color: context.colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
