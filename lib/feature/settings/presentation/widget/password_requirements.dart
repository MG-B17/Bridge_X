import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordRequirements extends StatelessWidget {
  const PasswordRequirements({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: context.colors.divider, width: 1),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outlined, color: context.colors.info, size: 18.w),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Password must be at least 8 characters long.',
              style: AppTextStyles.labelSmall.copyWith(
                color: context.colors.textSecondary,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
