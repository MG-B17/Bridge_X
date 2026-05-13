import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeamMembersSection extends StatelessWidget {
  const TeamMembersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.teamMembers,
          style: context.textTheme.labelMedium?.copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          AppStrings.inviteMembersManually,
          style: AppTextStyles.labelSmall.copyWith(
            color: colors.textSecondary,
          ),
        ),
        VerticalSpacing(AppSpacing.sm),
        GestureDetector(
          onTap: () {
            // TODO: Navigate to add members flow
          },
          child: Container(
            width: double.infinity,
            height: 48.h,
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
              border: Border.all(color: colors.primary, width: 1.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.group_add_outlined,
                  color: colors.primary,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  AppStrings.addMembers,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
