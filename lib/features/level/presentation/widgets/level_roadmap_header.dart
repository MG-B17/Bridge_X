import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/h_space.dart';

class LevelRoadmapHeader extends StatelessWidget {
  const LevelRoadmapHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.map_outlined, color: context.colors.primary, size: 20.w),
        HSpace(context.spacing.sm),
        Text(
          AppStrings.levelRoadmap,
          style: context.bodyLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.textPrimary,
          ),
        ),
      ],
    );
  }
}
