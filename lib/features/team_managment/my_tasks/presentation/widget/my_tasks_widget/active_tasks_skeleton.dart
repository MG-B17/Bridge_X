import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

const Color _shimmerBase = Color(0xFFE0E0E0);
const Color _shimmerHighlight = Color(0xFFF5F5F5);

class ActiveTasksSkeleton extends StatelessWidget {
  const ActiveTasksSkeleton({super.key});

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
        children: List.generate(
          4,
          (i) => Padding(
            padding: EdgeInsets.only(bottom: AppSpacing.md),
            child: const _SkeletonTaskCard(),
          ),
        ),
      ),
    );
  }
}

class _SkeletonTaskCard extends StatelessWidget {
  const _SkeletonTaskCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
        border: Border.all(color: context.colors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('PROJECT NAME'),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                ),
                child: Text(
                  'IN PROGRESS',
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ],
          ),
          VerticalSpacing(AppSpacing.xs),
          const Text('Task title skeleton placeholder'),
          VerticalSpacing(AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Progress'),
              Text('65%'),
            ],
          ),
          VerticalSpacing(AppSpacing.xs),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
            child: LinearProgressIndicator(
              value: 0.65,
              minHeight: 8.h,
            ),
          ),
          VerticalSpacing(AppSpacing.md),
          Container(height: 1.h, color: context.colors.divider),
          VerticalSpacing(AppSpacing.md),
          Row(
            children: [
              Icon(Icons.calendar_today_outlined, size: 16.sp),
              SizedBox(width: AppSpacing.xs),
              const Text('Due Date placeholder'),
            ],
          ),
        ],
      ),
    );
  }
}
