import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class TaskSummaryCards extends StatelessWidget {
  const TaskSummaryCards({
    super.key,
    required this.totalDone,
    required this.thisWeek,
  });

  final String totalDone;
  final String thisWeek;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ── Total Done Card ──
        Expanded(
          child: Container(
            padding: EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: context.colors.completedBg,
              borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TOTAL DONE',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.colors.completedText,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                VerticalSpacing(AppSpacing.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      totalDone,
                      style: context.textTheme.headlineMedium?.copyWith(
                        color: context.colors.completedText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: BoxDecoration(
                        color: context.colors.completedBg,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: context.colors.success,
                        size: 20.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        HorizontalSpacing(AppSpacing.md),

        // ── This Week Card ──
        Expanded(
          child: Container(
            padding: EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: context.colors.ongoingBg,
              borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'THIS WEEK',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.colors.ongoingText,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                VerticalSpacing(AppSpacing.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      thisWeek,
                      style: context.textTheme.headlineMedium?.copyWith(
                        color: context.colors.ongoingText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.trending_up,
                      color: context.colors.primary,
                      size: 28.sp,
                    ),
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
