import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';
import '../widgets/level_header.dart';
import '../widgets/level_activity_card.dart';
import '../widgets/level_roadmap_header.dart';
import '../widgets/level_info_card_widget.dart';
import '../widgets/roadmap_step_widget.dart';
import '../widgets/tier_card_widget.dart';

class LevelScreen extends StatelessWidget {
  const LevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.scaffoldBg,
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
        padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LevelHeader(),
            VSpace(context.spacing.xxl),
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
                            color: context.colors.primary.withValues(alpha: 0.7),
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.auto_awesome_outlined,
                    color: context.colors.primary.withValues(alpha: 0.3),
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
            VSpace(context.spacing.xl),
            _buildStatsRow(),
            VSpace(context.spacing.xl),
            const LevelActivityCard(),
            VSpace(context.spacing.xxl),
            const LevelRoadmapHeader(),
            VSpace(context.spacing.xl),
            const RoadmapStepWidget(
              title: AppStrings.beginnerTier,
              pills: [AppStrings.bronze, AppStrings.silver, AppStrings.gold],
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
            VSpace(context.spacing.xxl),
        ],
        ),
      ),
    );
  }



  Widget _buildStatsRow() {
    return Row(
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
    );
  }
}
