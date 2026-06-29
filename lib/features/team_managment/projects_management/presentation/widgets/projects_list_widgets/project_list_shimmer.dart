import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectListShimmer extends StatelessWidget {
  const ProjectListShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(
        top: AppSpacing.spacing16,
        bottom: AppSpacing.spacing32,
      ),
      itemCount: itemCount,
      separatorBuilder: (_, _) => VerticalSpacing(AppSpacing.md),
      itemBuilder: (_, _) => _ShimmerCard(),
    );
  }
}

class _ShimmerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Status Badge',
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
          ),
          VerticalSpacing(AppSpacing.sm),
          Text(
            'Project Title Here',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
          ),
          VerticalSpacing(AppSpacing.sm),
          Text(
            'Progress bar placeholder',
            style: TextStyle(fontSize: 14.sp),
          ),
          VerticalSpacing(AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Avatar stack',
                style: TextStyle(fontSize: 14.sp),
              ),
              Text(
                'Details',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
