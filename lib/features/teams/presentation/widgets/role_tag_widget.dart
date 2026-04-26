import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/h_space.dart';

class RoleTagWidget extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;

  const RoleTagWidget({
    super.key,
    required this.label,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFFDBEAFE).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: context.labelSmall.copyWith(
              color: context.colors.primary,
              fontWeight: FontWeight.w900,
            ),
          ),
          HSpace(context.spacing.xs),
          GestureDetector(
            onTap: onRemove,
            child: Icon(
              Icons.close_rounded,
              color: context.colors.primary,
              size: 14.w,
            ),
          ),
        ],
      ),
    );
  }
}
