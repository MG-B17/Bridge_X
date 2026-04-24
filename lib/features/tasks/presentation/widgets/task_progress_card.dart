import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';

enum TaskStatus { inProgress, pending, nearCompletion, completed }

class TaskProgressCard extends StatelessWidget {
  final String projectName;
  final String taskTitle;
  final TaskStatus status;
  final double progressValue;
  final String dueDate;
  final VoidCallback? onTap;

  const TaskProgressCard({
    super.key,
    required this.projectName,
    required this.taskTitle,
    required this.status,
    required this.progressValue,
    required this.dueDate,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: context.spacing.md),
        padding: EdgeInsets.all(context.spacing.lg),
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
          border: Border.all(color: context.colors.divider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            VSpace(context.spacing.xs),
            Text(
              taskTitle,
              style: context.titleLarge.copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
            VSpace(context.spacing.md),
            _buildProgressBar(context),
            VSpace(context.spacing.md),
            _buildDueDate(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          projectName.toUpperCase(),
          style: context.labelSmall.copyWith(
            color: context.colors.textSecondary,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        _buildStatusBadge(context),
      ],
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    final statusConfig = _getStatusConfig(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: statusConfig.bgColor,
        borderRadius: BorderRadius.circular(context.spacing.radiusPill),
        border: Border.all(color: statusConfig.borderColor),
      ),
      child: Text(
        statusConfig.label,
        style: context.labelSmall.copyWith(
          color: statusConfig.textColor,
          fontWeight: FontWeight.w900,
          fontSize: 10.sp,
        ),
      ),
    );
  }

  Widget _buildProgressBar(BuildContext context) {
    final progressColor = _getProgressColor();
    final percentage = (progressValue * 100).toInt();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.progress,
              style: context.labelSmall.copyWith(
                color: context.colors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '$percentage%',
              style: context.labelSmall.copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        VSpace(context.spacing.xs),
        ClipRRect(
          borderRadius: BorderRadius.circular(context.spacing.radiusXs),
          child: LinearProgressIndicator(
            value: progressValue,
            minHeight: 6.h,
            backgroundColor: context.colors.divider.withValues(alpha: 0.5),
            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
          ),
        ),
      ],
    );
  }

  Widget _buildDueDate(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.calendar_today_outlined,
          size: 14.w,
          color: context.colors.textSecondary,
        ),
        SizedBox(width: 6.w),
        Text(
          dueDate,
          style: context.labelSmall.copyWith(
            color: context.colors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Color _getProgressColor() {
    switch (status) {
      case TaskStatus.inProgress:
        return const Color(0xFF2D4B73);
      case TaskStatus.pending:
        return const Color(0xFFFFA726);
      case TaskStatus.nearCompletion:
        return const Color(0xFF10B981);
      case TaskStatus.completed:
        return const Color(0xFF10B981);
    }
  }

  _StatusConfig _getStatusConfig(BuildContext context) {
    switch (status) {
      case TaskStatus.inProgress:
        return _StatusConfig(
          label: AppStrings.inProgress.toUpperCase(),
          textColor: context.colors.ongoingText,
          bgColor: context.colors.ongoingBg,
          borderColor: context.colors.ongoingBg,
        );
      case TaskStatus.pending:
        return _StatusConfig(
          label: AppStrings.pending.toUpperCase(),
          textColor: const Color(0xFFD97706),
          bgColor: const Color(0xFFFFF7ED),
          borderColor: const Color(0xFFFFF7ED),
        );
      case TaskStatus.nearCompletion:
        return _StatusConfig(
          label: AppStrings.nearCompletion.toUpperCase(),
          textColor: context.colors.completedText,
          bgColor: context.colors.completedBg,
          borderColor: context.colors.completedBg,
        );
      case TaskStatus.completed:
        return _StatusConfig(
          label: AppStrings.completed.toUpperCase(),
          textColor: context.colors.completedText,
          bgColor: context.colors.completedBg,
          borderColor: context.colors.completedBg,
        );
    }
  }
}

class _StatusConfig {
  final String label;
  final Color textColor;
  final Color bgColor;
  final Color borderColor;

  const _StatusConfig({
    required this.label,
    required this.textColor,
    required this.bgColor,
    required this.borderColor,
  });
}
