import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bridgex/core/utils/extensions.dart';

class InfoCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const InfoCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: context.colors.secondary.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: context.colors.primary,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20.w,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: context.labelSmall.copyWith(
                    color: context.colors.primary,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.1,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: context.bodyMedium.copyWith(
                    color: context.colors.primary.withValues(alpha: 0.8),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
