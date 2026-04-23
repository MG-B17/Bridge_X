import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/text_style.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../../core/widgets/v_space.dart';
import '../widgets/info_card_widget.dart';
import '../widgets/progress_circle_widget.dart';
import '../widgets/status_item_widget.dart';

class MatchingScreen extends StatelessWidget {
  const MatchingScreen({super.key});

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
            decoration: BoxDecoration(
              color: context.colors.primary.withOpacity(0.1),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            VSpace(context.spacing.sm),
            Text(
              AppStrings.matching,
              textAlign: TextAlign.center,
              style: context.displayLarge.copyWith(
                color: context.colors.primary,
                height: 1.2,
              ),
            ),
            VSpace(context.spacing.md),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                AppStrings.matchingSubtitle,
                textAlign: TextAlign.center,
                style: context.bodyMedium.copyWith(
                  color: context.colors.textSecondary,
                  height: 1.5,
                ),
              ),
            ),
            VSpace(40.h),
            GestureDetector(
              onTap: () => context.push(AppRouteConstant.teams),
              child: const ProgressCircleWidget(
                percentage: 45,
                statusText: AppStrings.optimizing,
              ),
            ),
            VSpace(40.h),
            const InfoCardWidget(
              icon: Icons.psychology_outlined,
              title: AppStrings.dynamicInsight,
              subtitle: AppStrings.dynamicInsightSubtitle,
            ),
            VSpace(30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.coreSkillScan,
                  style: context.labelSmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colors.primary.withOpacity(0.6),
                  ),
                ),
                Text(
                  AppStrings.matchingDot,
                  style: context.labelSmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colors.primary,
                  ),
                ),
              ],
            ),
            VSpace(context.spacing.sm),
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: LinearProgressIndicator(
                value: 0.6,
                minHeight: 8.h,
                backgroundColor: context.colors.primary.withOpacity(0.1),
                valueColor: AlwaysStoppedAnimation<Color>(context.colors.primary),
              ),
            ),
            VSpace(30.h),
            const StatusItemWidget(
              label: AppStrings.skillsVerified,
              status: StatusType.success,
            ),
            const StatusItemWidget(
              label: AppStrings.experienceAnalyzed,
              status: StatusType.success,
            ),
            const StatusItemWidget(
              label: AppStrings.finalizingShortlist,
              status: StatusType.pending,
            ),
            VSpace(context.spacing.lg),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) context.go(AppRouteConstant.matching);
          if (index == 1) context.go(AppRouteConstant.chat);
          if (index == 2) context.go(AppRouteConstant.teams);
          if (index == 3) context.go(AppRouteConstant.profile);
        },
      ),
    );
  }
}
