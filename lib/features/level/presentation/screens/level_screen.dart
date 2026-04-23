import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/text_style.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../../core/widgets/v_space.dart';
import '../widgets/level_info_card_widget.dart';
import '../widgets/roadmap_step_widget.dart';
import '../widgets/tier_card_widget.dart';

class LevelScreen extends StatelessWidget {
  const LevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: context.colors.primary, size: 20.sp),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VSpace(10.h),
            Text(
              AppStrings.yourLevel,
              style: context.displayLarge.copyWith(
                color: context.colors.primary,
                fontSize: 28.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              AppStrings.trackGrowth,
              style: context.bodyMedium.copyWith(
                color: context.colors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            VSpace(30.h),
            const TierCardWidget(
              currentTier: AppStrings.beginnerSilver,
              nextTierInfo: AppStrings.nextTierRequirement,
              progress: 0.7,
            ),
            VSpace(24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                LevelInfoCardWidget(
                  value: '128',
                  label: 'Completed Tasks',
                  icon: Icons.check_circle_outline_rounded,
                ),
                LevelInfoCardWidget(
                  value: '4.8',
                  label: AppStrings.averageRating,
                  icon: Icons.star_outline_rounded,
                  badge: AppStrings.top5Percent,
                ),
              ],
            ),
            VSpace(24.h),
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.bolt_rounded,
                      color: context.colors.primary,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.highActivityConsistency,
                          style: context.bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colors.primary,
                          ),
                        ),
                        Text(
                          AppStrings.performanceCalculatedAI,
                          style: context.labelSmall.copyWith(
                            color: context.colors.primary.withOpacity(0.7),
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.auto_awesome_outlined,
                    color: context.colors.primary.withOpacity(0.3),
                    size: 24.sp,
                  ),
                ],
              ),
            ),
            VSpace(30.h),
            Row(
              children: [
                Icon(Icons.map_outlined, color: context.colors.primary, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  AppStrings.levelRoadmap,
                  style: context.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colors.textPrimary,
                  ),
                ),
              ],
            ),
            VSpace(24.h),
            RoadmapStepWidget(
              title: AppStrings.beginnerTier,
              pills: const [AppStrings.bronze, AppStrings.silver, AppStrings.gold],
              activePill: AppStrings.silver,
              isCompleted: true,
            ),
            RoadmapStepWidget(
              title: AppStrings.juniorTier,
              pills: const [AppStrings.bronze, AppStrings.silver, AppStrings.gold],
              isLocked: true,
            ),
            RoadmapStepWidget(
              title: AppStrings.seniorTier,
              pills: const [AppStrings.bronze, AppStrings.silver, AppStrings.gold],
              isLocked: true,
              showLine: false,
            ),
            VSpace(30.h),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 3, // Profile context
        onTap: (index) {},
      ),
    );
  }
}
