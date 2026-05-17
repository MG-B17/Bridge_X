import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/app_color_schema.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoTeamsIllustration extends StatelessWidget {
  const NoTeamsIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: 220.w,
      height: 140.h,
      decoration: BoxDecoration(
        color: colors.primaryLight.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
      ),
      child: Center(
        child: Container(
          width: 160.w,
          height: 100.h,
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
            boxShadow: AppSpacing.subtleShadow,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background circles
              Positioned(
                left: 30.w,
                child: CircleAvatar(
                  radius: 14.r,
                  backgroundColor: colors.divider.withValues(alpha: 0.4),
                ),
              ),
              Positioned(
                right: 30.w,
                child: CircleAvatar(
                  radius: 14.r,
                  backgroundColor: colors.divider.withValues(alpha: 0.4),
                ),
              ),
              // Search icon
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  gradient: AppColorScheme.matching,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
                ),
                child: Icon(
                  Icons.manage_search_rounded,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
              // Orange dot
              Positioned(
                top: 20.h,
                right: 40.w,
                child: CircleAvatar(
                  radius: 5.r,
                  backgroundColor: colors.amber,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
