import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/h_space.dart';
import '../../../../core/widgets/v_space.dart';

class TaskItemWidget extends StatelessWidget {
  final String title;
  final String dueDate;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;

  const TaskItemWidget({
    super.key,
    required this.title,
    required this.dueDate,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.spacing.sm),
      padding: EdgeInsets.all(context.spacing.md),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(context.spacing.radiusCard),
        border: Border.all(color: context.colors.divider),
      ),
      child: Row(
        children: [
          _buildIcon(context),
          HSpace(context.spacing.md),
          Expanded(child: _buildInfo(context)),
          _buildStatusBadge(context),
        ],
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: iconBgColor,
        borderRadius: BorderRadius.circular(context.spacing.radiusCard),
      ),
      child: Icon(icon, color: iconColor, size: 20.w),
    );
  }

  Widget _buildInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.bodyLarge.copyWith(fontWeight: FontWeight.w900, color: context.colors.textPrimary),
        ),
        VSpace(context.spacing.xxs),
        Text(
          dueDate,
          style: context.labelSmall.copyWith(color: context.colors.textSecondary, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: context.colors.divider.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(context.spacing.radiusCard),
      ),
      child: Text(
        AppStrings.todo,
        style: context.labelSmall.copyWith(
          color: context.colors.textSecondary,
          fontWeight: FontWeight.w900,
          fontSize: 10.sp,
        ),
      ),
    );
  }
}
