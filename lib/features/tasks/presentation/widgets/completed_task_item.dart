import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/h_space.dart';

class CompletedTaskItem extends StatelessWidget {
  final String title;
  final String completedDate;
  final VoidCallback? onMenuTap;

  const CompletedTaskItem({
    super.key,
    required this.title,
    required this.completedDate,
    this.onMenuTap,
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
          _buildCheckIcon(context),
          HSpace(context.spacing.md),
          Expanded(child: _buildInfo(context)),
          _buildMenuButton(context),
        ],
      ),
    );
  }

  Widget _buildCheckIcon(BuildContext context) {
    return Container(
      width: 36.w,
      height: 36.w,
      decoration: BoxDecoration(
        color: context.colors.completedBg,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.check_circle,
        color: context.colors.completedText,
        size: 22.w,
      ),
    );
  }

  Widget _buildInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.bodyLarge.copyWith(
            fontWeight: FontWeight.w700,
            color: context.colors.textPrimary,
          ),
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 12.w,
              color: context.colors.textSecondary,
            ),
            SizedBox(width: 4.w),
            Text(
              completedDate,
              style: context.labelSmall.copyWith(
                color: context.colors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMenuButton(BuildContext context) {
    return GestureDetector(
      onTap: onMenuTap,
      child: Icon(
        Icons.more_vert,
        color: context.colors.textHint,
        size: 20.w,
      ),
    );
  }
}
