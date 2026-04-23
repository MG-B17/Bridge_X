import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/text_style.dart';

class ProgressCircleWidget extends StatelessWidget {
  final double percentage;
  final String statusText;

  const ProgressCircleWidget({
    super.key,
    required this.percentage,
    required this.statusText,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 140.w,
          height: 140.w,
          child: CircularProgressIndicator(
            value: percentage / 100,
            strokeWidth: 8.w,
            backgroundColor: AppColors.secondary,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            strokeCap: StrokeCap.round,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${percentage.toInt()}%',
              style: AppTextStyles.displayLarge.copyWith(
                color: AppColors.primary,
                fontSize: 28.sp,
              ),
            ),
            Text(
              statusText.toUpperCase(),
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
