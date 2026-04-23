import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/h_space.dart';
import '../../../../core/widgets/v_space.dart';

class NotificationItemWidget extends StatelessWidget {
  final String category, title, message, time;
  final IconData icon;
  final Color iconBgColor, iconColor;
  final bool isNew, showDivider;

  const NotificationItemWidget({
    super.key,
    required this.category,
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    this.isNew = false,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: context.spacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIcon(),
              HSpace(context.spacing.md),
              Expanded(child: _buildContent(context)),
            ],
          ),
        ),
        if (showDivider) Divider(height: 1, color: context.colors.divider),
      ],
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 48.w,
      height: 48.w,
      decoration: BoxDecoration(color: iconBgColor, borderRadius: BorderRadius.circular(12.r)),
      child: Icon(icon, color: iconColor, size: 24.w),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(context),
        VSpace(context.spacing.xxs),
        Text(title, style: context.titleLarge.copyWith(color: context.colors.textPrimary, fontSize: 16.sp, fontWeight: FontWeight.w900)),
        VSpace(context.spacing.xxs),
        Text(message, style: context.bodyMedium.copyWith(color: context.colors.textSecondary, height: 1.4)),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(category, style: context.bodyMedium.copyWith(color: context.colors.primary, fontWeight: FontWeight.w900, fontSize: 14.sp)),
        Row(
          children: [
            Text(time, style: context.labelSmall.copyWith(color: context.colors.textSecondary)),
            if (isNew) ...[
              HSpace(context.spacing.sm),
              Container(width: 8.w, height: 8.w, decoration: BoxDecoration(color: context.colors.primary, shape: BoxShape.circle)),
            ],
          ],
        ),
      ],
    );
  }
}
