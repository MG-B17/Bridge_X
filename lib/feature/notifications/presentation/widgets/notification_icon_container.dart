import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationIconContainer extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final double iconSize;
  final double padding;

  const NotificationIconContainer({
    super.key,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    this.iconSize = 24,
    this.padding = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding.w),
      decoration: BoxDecoration(
        color: iconBg,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: iconColor, size: iconSize.sp),
    );
  }
}
