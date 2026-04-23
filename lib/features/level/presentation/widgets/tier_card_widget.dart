import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/text_style.dart';
import '../../../../core/utils/extensions.dart';

class TierCardWidget extends StatelessWidget {
  final String currentTier;
  final String nextTierInfo;
  final double progress;

  const TierCardWidget({
    super.key,
    required this.currentTier,
    required this.nextTierInfo,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: context.colors.primary,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: context.colors.primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10.w,
            top: -10.h,
            child: Icon(
              Icons.stars_rounded,
              size: 100.sp,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CURRENT TIER',
                style: context.labelSmall.copyWith(
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                currentTier,
                style: context.displayLarge.copyWith(
                  color: Colors.white,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Progress to Gold',
                    style: context.bodyMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: context.bodyMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 10.h,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF83A0E7)),
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Text(
                    nextTierInfo,
                    style: context.labelSmall.copyWith(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12.sp,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.flag_outlined,
                    color: Colors.white.withOpacity(0.7),
                    size: 16.sp,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
