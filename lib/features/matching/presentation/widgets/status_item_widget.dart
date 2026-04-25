import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/text_style.dart';

enum StatusType { success, completed, pending }

class StatusItemWidget extends StatelessWidget {
  final String label;
  final StatusType status;

  const StatusItemWidget({
    super.key,
    required this.label,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color iconColor;
    IconData iconData;
    Color textColor = status == StatusType.pending ? AppColors.textSecondary.withValues(alpha: 0.5) : AppColors.textPrimary;

    switch (status) {
      case StatusType.success:
      case StatusType.completed:
        iconColor = AppColors.success;
        iconData = Icons.check_circle;
        break;
      case StatusType.pending:
        iconColor = AppColors.success.withValues(alpha: 0.3);
        iconData = Icons.radio_button_unchecked;
        break;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: status == StatusType.pending ? Colors.transparent : AppColors.card,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: status == StatusType.pending
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            color: iconColor,
            size: 24.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
