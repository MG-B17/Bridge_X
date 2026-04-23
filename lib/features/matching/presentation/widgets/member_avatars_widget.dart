import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/text_style.dart';

class MemberAvatarsWidget extends StatelessWidget {
  final int count;
  final String label;

  const MemberAvatarsWidget({
    super.key,
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 70.w,
          height: 32.h,
          child: Stack(
            children: [
              _buildAvatar(0, Colors.amber),
              _buildAvatar(1, Colors.blueGrey),
              _buildAvatar(2, AppColors.primary, isLast: true),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar(int index, Color color, {bool isLast = false}) {
    return Positioned(
      left: index * 18.w,
      child: Container(
        width: 32.w,
        height: 32.w,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2.w),
        ),
        child: isLast
            ? Center(
                child: Text(
                  '+1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : const Icon(Icons.person, color: Colors.white, size: 16),
      ),
    );
  }
}
