import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/extensions.dart';

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
            backgroundColor: context.colors.secondary,
            valueColor: AlwaysStoppedAnimation<Color>(context.colors.primary),
            strokeCap: StrokeCap.round,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${percentage.toInt()}%',
              style: context.displayLarge.copyWith(
                color: context.colors.primary,
                fontSize: 28.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              statusText.toUpperCase(),
              style: context.labelSmall.copyWith(
                color: context.colors.primary,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
