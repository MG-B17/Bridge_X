import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/extensions.dart';

class TagWidget extends StatelessWidget {
  final String label;

  const TagWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: context.colors.secondary.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        label,
        style: context.labelSmall.copyWith(
          color: context.colors.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
