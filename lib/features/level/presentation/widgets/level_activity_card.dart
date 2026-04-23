import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/h_space.dart';

class LevelActivityCard extends StatelessWidget {
  const LevelActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.spacing.lg),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(context.spacing.sm),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.bolt_rounded,
              color: context.colors.primary,
              size: 24.w,
            ),
          ),
          HSpace(context.spacing.md),
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
            size: 24.w,
          ),
        ],
      ),
    );
  }
}
