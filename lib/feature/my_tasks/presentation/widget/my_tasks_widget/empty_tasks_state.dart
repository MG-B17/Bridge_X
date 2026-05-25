import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_button.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class EmptyTasksState extends StatelessWidget {
  const EmptyTasksState({super.key, required this.onExploreTap});

  final VoidCallback onExploreTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 180.h,
          width: 220.w,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 10.w,
                bottom: 10.h,
                child: Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: context.colors.divider,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.eco,
                      color: context.colors.success,
                      size: 28.sp,
                    ),
                  ),
                ),
              ),
              Container(
                width: 110.w,
                height: 130.h,
                decoration: BoxDecoration(
                  color: context.colors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: context.colors.primary.withValues(alpha: 0.1),
                      blurRadius: 20.r,
                      offset: Offset(0, 8.h),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: context.colors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_box_outlined,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                    VerticalSpacing(12),
                    Container(
                      width: 50.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    VerticalSpacing(6.h),
                    Container(
                      width: 35.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 35.w,
                top: 5.h,
                child: Container(
                  padding: EdgeInsets.all(6.r),
                  decoration: BoxDecoration(
                    color: context.colors.warning.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.star,
                    color: context.colors.warning,
                    size: 20.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
        VerticalSpacing(AppSpacing.xl),
        Text(
          AppStrings.allCaughtUp,
          style: context.textTheme.headlineSmall?.copyWith(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        VerticalSpacing(AppSpacing.sm),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Text(
            '${AppStrings.noActiveTasks}\n${AppStrings.takeBreak}',
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colors.textSecondary,
              height: 1.5,
            ),
          ),
        ),
        VerticalSpacing(AppSpacing.xxl),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 48.0.w),
          child: BridgeXButton(
            text: AppStrings.exploreProjects,
            suffixicon: Icons.arrow_forward,
            onTap: onExploreTap,
          ),
        ),
      ],
    );
  }
}
