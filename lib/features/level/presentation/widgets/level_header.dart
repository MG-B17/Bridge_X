import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';

class LevelHeader extends StatelessWidget {
  const LevelHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VSpace(context.spacing.sm),
        Text(
          AppStrings.yourLevel,
          style: context.displayLarge.copyWith(
            color: context.colors.primary,
            fontSize: 28.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
        VSpace(context.spacing.xs),
        Text(
          AppStrings.trackGrowth,
          style: context.bodyMedium.copyWith(
            color: context.colors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
