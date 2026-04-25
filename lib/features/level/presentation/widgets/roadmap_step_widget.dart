import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/extensions.dart';

class RoadmapStepWidget extends StatelessWidget {
  final String title;
  final List<String> pills;
  final String activePill;
  final bool isCompleted;
  final bool isLocked;
  final bool showLine;

  const RoadmapStepWidget({
    super.key,
    required this.title,
    required this.pills,
    this.activePill = '',
    this.isCompleted = false,
    this.isLocked = false,
    this.showLine = true,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? context.colors.primary
                      : isLocked
                          ? context.colors.divider
                          : context.colors.divider,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: isCompleted
                      ? Icon(Icons.check, color: Colors.white, size: 16.sp)
                      : Container(
                          width: 12.w,
                          height: 12.w,
                          decoration: BoxDecoration(
                            color: isLocked ? Colors.transparent : context.colors.textHint.withValues(alpha: 0.3),
                            shape: BoxShape.circle,
                          ),
                        ),
                ),
              ),
              if (showLine)
                Expanded(
                  child: Container(
                    width: 2.w,
                    color: context.colors.divider,
                  ),
                ),
            ],
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.labelSmall.copyWith(
                    color: isLocked ? context.colors.textHint : context.colors.primary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
                SizedBox(height: 12.h),
                Wrap(
                  spacing: 8.w,
                  children: pills.map((pill) {
                    final isActive = pill == activePill;
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: isActive
                            ? context.colors.primary
                            : isLocked
                                ? context.colors.divider.withValues(alpha: 0.5)
                                : context.colors.divider.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(12.r),
                        border: isLocked && !isActive
                            ? Border.all(color: context.colors.textHint.withValues(alpha: 0.1), width: 1.w)
                            : null,
                      ),
                      child: Text(
                        pill,
                        style: context.labelSmall.copyWith(
                          color: isActive
                              ? Colors.white
                              : isLocked
                                  ? context.colors.textHint.withValues(alpha: 0.5)
                                  : context.colors.textPrimary.withValues(alpha: 0.5),
                          fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
