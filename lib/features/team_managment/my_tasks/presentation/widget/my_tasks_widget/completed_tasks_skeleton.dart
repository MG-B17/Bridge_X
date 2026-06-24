import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/team_managment/utils/task_strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

const Color _shimmerBase = Color(0xFFE0E0E0);
const Color _shimmerHighlight = Color(0xFFF5F5F5);

class CompletedTasksSkeleton extends StatelessWidget {
  const CompletedTasksSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      effect: const ShimmerEffect(
        baseColor: _shimmerBase,
        highlightColor: _shimmerHighlight,
        duration: Duration(milliseconds: 1200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SkeletonSummaryCards(),
          VerticalSpacing(AppSpacing.lg),
          Row(
            children: [
              Text(TaskStrings.recentlyFinished),
              SizedBox(width: AppSpacing.xs),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 2.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
                ),
                child: const Text('0 DONE'),
              ),
            ],
          ),
          VerticalSpacing(AppSpacing.md),
          ...List.generate(
            3,
            (i) => Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.md),
              child: const _SkeletonCompletedCard(),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkeletonSummaryCards extends StatelessWidget {
  const _SkeletonSummaryCards();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('TOTAL DONE'),
                VerticalSpacing(AppSpacing.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('0'),
                    Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.check, size: 20.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: AppSpacing.md),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('THIS WEEK'),
                VerticalSpacing(AppSpacing.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('0'),
                    Icon(Icons.trending_up, size: 28.sp),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SkeletonCompletedCard extends StatelessWidget {
  const _SkeletonCompletedCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.spacing16,
        vertical: AppSpacing.spacing8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radius12),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(AppSpacing.radius6),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              size: AppSpacing.spacing16,
            ),
          ),
          SizedBox(width: AppSpacing.spacing16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Completed task title skeleton'),
                VerticalSpacing(AppSpacing.spacing4),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: AppSpacing.fontSize12,
                    ),
                    SizedBox(width: AppSpacing.spacing4),
                    const Text('Completed date'),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.more_vert),
        ],
      ),
    );
  }
}
