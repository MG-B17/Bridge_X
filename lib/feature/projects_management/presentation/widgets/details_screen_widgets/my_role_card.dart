import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyRoleCard extends StatelessWidget {
  const MyRoleCard({super.key, required this.myTrack});

  final String myTrack;

  static String formatTrack(String track) {
    if (track.isEmpty) return track;
    return track
        .split(RegExp(r'[_\s]+'))
        .where((w) => w.isNotEmpty)
        .map((w) => '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}')
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final formattedTrack = formatTrack(myTrack);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
        border: Border.all(color: colors.divider.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.engineering_outlined,
                size: 16.sp,
                color: colors.secondary,
              ),
              HorizontalSpacing(AppSpacing.xs),
              Text(
                AppStrings.myRole,
                style: AppTextStyles.labelSmall.copyWith(
                  color: colors.secondary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  fontSize: AppSpacing.fontSize10,
                ),
              ),
            ],
          ),
          VerticalSpacing(AppSpacing.md),
          Text(
            formattedTrack,
            style: AppTextStyles.headlineSmall.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
