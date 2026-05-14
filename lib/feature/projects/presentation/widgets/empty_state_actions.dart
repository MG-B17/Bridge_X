import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Two CTA buttons shown in the empty-projects state:
///
/// 1. **Explore Public Teams** — outlined with accent (burgundy/pink) text + arrow.
/// 2. **Create Team** — outlined with icon.
class EmptyStateActions extends StatelessWidget {
  const EmptyStateActions({
    super.key,
    this.onExploreTeams,
    this.onCreateTeam,
  });

  final VoidCallback? onExploreTeams;
  final VoidCallback? onCreateTeam;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      children: [
        // ── Explore Public Teams ──
        GestureDetector(
          onTap: onExploreTeams,
          child: Container(
            width: double.infinity,
            height: 56.h,
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: colors.divider,
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.exploreTeams,
                  style: AppTextStyles.titleLarge.copyWith(
                    color: colors.accent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.arrow_forward,
                  color: colors.accent,
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
        VerticalSpacing(AppSpacing.sm),

        // ── Create Team ──
        GestureDetector(
          onTap: onCreateTeam,
          child: Container(
            width: double.infinity,
            height: 56.h,
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: colors.divider,
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.groups_outlined,
                  color: colors.textPrimary,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  AppStrings.createTeam,
                  style: AppTextStyles.titleLarge.copyWith(
                    color: colors.textPrimary,
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
