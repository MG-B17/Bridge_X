import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/h_space.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.xl,
        vertical: context.spacing.sm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.spacing.md,
              vertical: context.spacing.xs,
            ),
            decoration: BoxDecoration(
              color: context.colors.divider.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(context.spacing.radiusCard),
              border: Border.all(color: context.colors.divider),
            ),
            child: Row(
              children: [
                Text(
                  AppStrings.edit,
                  style: context.labelSmall.copyWith(
                    color: context.colors.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                HSpace(context.spacing.xs),
                Icon(Icons.edit_outlined, color: context.colors.primary, size: 14.w),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
