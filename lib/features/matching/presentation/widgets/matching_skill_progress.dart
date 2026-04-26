import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';

class MatchingSkillProgress extends StatelessWidget {
  const MatchingSkillProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.coreSkillScan.toUpperCase(),
              style: context.labelSmall.copyWith(
                fontWeight: FontWeight.w900,
                color: context.colors.primary.withValues(alpha: 0.6),
                letterSpacing: 1.2,
              ),
            ),
            Text(
              AppStrings.matchingDot,
              style: context.labelSmall.copyWith(
                fontWeight: FontWeight.w900,
                color: context.colors.primary,
              ),
            ),
          ],
        ),
        VSpace(context.spacing.sm),
        ClipRRect(
          borderRadius: BorderRadius.circular(context.spacing.radiusXs),
          child: LinearProgressIndicator(
            value: 0.6,
            minHeight: 8.w,
            backgroundColor: context.colors.primary.withValues(alpha: 0.1),
            valueColor: AlwaysStoppedAnimation<Color>(context.colors.primary),
          ),
        ),
      ],
    );
  }
}
