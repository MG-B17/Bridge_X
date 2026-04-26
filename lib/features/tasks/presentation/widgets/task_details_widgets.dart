import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/h_space.dart';
import '../../../../core/widgets/v_space.dart';
import '../../../../core/theme/app_color_scheme.dart';

class TaskDetailsBanner extends StatelessWidget {
  final String taskTitle;
  final String statusLabel;
  final String priorityLabel;

  const TaskDetailsBanner({
    super.key,
    required this.taskTitle,
    required this.statusLabel,
    required this.priorityLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.spacing.xl),
      decoration: BoxDecoration(
        gradient: AppColorScheme.gradient,
        borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildBadge(
                context,
                statusLabel.toUpperCase(),
                Colors.white.withValues(alpha: 0.2),
                Colors.white,
              ),
              HSpace(context.spacing.sm),
              _buildBadge(
                context,
                priorityLabel.toUpperCase(),
                const Color(0xFFEF4444).withValues(alpha: 0.8),
                Colors.white,
              ),
            ],
          ),
          VSpace(context.spacing.md),
          Text(
            taskTitle,
            style: context.displayLarge.copyWith(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(
    BuildContext context,
    String label,
    Color bgColor,
    Color textColor,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(context.spacing.radiusPill),
      ),
      child: Text(
        label,
        style: context.labelSmall.copyWith(
          color: textColor,
          fontWeight: FontWeight.w900,
          fontSize: 10.sp,
        ),
      ),
    );
  }
}

class TaskDescriptionCard extends StatelessWidget {
  final String description;

  const TaskDescriptionCard({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel(context, AppStrings.description),
        VSpace(context.spacing.sm),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(context.spacing.lg),
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
            border: Border.all(color: context.colors.divider),
          ),
          child: Text(
            description,
            style: context.bodyMedium.copyWith(
              color: context.colors.textPrimary,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}

class TaskDueDateCard extends StatelessWidget {
  final String date;

  const TaskDueDateCard({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.spacing.lg),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
        border: Border.all(color: context.colors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.dueDate.toUpperCase(),
            style: context.labelSmall.copyWith(
              color: context.colors.textSecondary,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
          VSpace(context.spacing.sm),
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 18.w,
                color: context.colors.textPrimary,
              ),
              HSpace(context.spacing.sm),
              Text(
                date,
                style: context.bodyLarge.copyWith(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TaskCreatedByCard extends StatelessWidget {
  final String name;
  final String? avatarUrl;

  const TaskCreatedByCard({
    super.key,
    required this.name,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.lg,
        vertical: context.spacing.md,
      ),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
        border: Border.all(color: context.colors.divider),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppStrings.createdBy.toUpperCase(),
            style: context.labelSmall.copyWith(
              color: context.colors.textSecondary,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 14.r,
                backgroundColor: context.colors.primary.withValues(alpha: 0.1),
                backgroundImage: avatarUrl != null
                    ? NetworkImage(avatarUrl!)
                    : null,
                child: avatarUrl == null
                    ? Text(
                        name.isNotEmpty ? name[0].toUpperCase() : '?',
                        style: context.labelSmall.copyWith(
                          color: context.colors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
              HSpace(context.spacing.sm),
              Text(
                name,
                style: context.bodyMedium.copyWith(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TaskAttachmentItem extends StatelessWidget {
  final String fileName;
  final String fileSize;
  final String addedDate;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final VoidCallback? onDownload;

  const TaskAttachmentItem({
    super.key,
    required this.fileName,
    required this.fileSize,
    required this.addedDate,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.spacing.sm),
      padding: EdgeInsets.all(context.spacing.md),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
        border: Border.all(color: context.colors.divider),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(context.spacing.radiusCard),
            ),
            child: Icon(icon, color: iconColor, size: 20.w),
          ),
          HSpace(context.spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: context.bodyMedium.copyWith(
                    color: context.colors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '$fileSize • $addedDate',
                  style: context.labelSmall.copyWith(
                    color: context.colors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onDownload,
            child: Icon(
              Icons.download_outlined,
              color: context.colors.primary,
              size: 22.w,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildSectionLabel(BuildContext context, String label) {
  return Text(
    label.toUpperCase(),
    style: context.labelSmall.copyWith(
      color: context.colors.textSecondary,
      fontWeight: FontWeight.w900,
      letterSpacing: 1.2,
    ),
  );
}
