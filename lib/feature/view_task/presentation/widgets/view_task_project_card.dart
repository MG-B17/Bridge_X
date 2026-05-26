import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewTaskProjectCard extends StatelessWidget {
  const ViewTaskProjectCard({super.key, required this.teamName, required this.myTrack});

  final String teamName;
  final String myTrack;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colors.secondary,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: colors.onGoingColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
            ),
            child: Icon(Icons.dashboard_outlined, color: colors.onGoingColor, size: 22.sp),
          ),
          HorizontalSpacing(AppSpacing.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(color: colors.onGoingColor, shape: BoxShape.circle),
                    ),
                    HorizontalSpacing(AppSpacing.spacing4),
                    Text('Ongoing', style: AppTextStyles.labelSmall.copyWith(color: colors.surface.withValues(alpha: 0.8))),
                  ],
                ),
                VerticalSpacing(AppSpacing.spacing4),
                Text(teamName, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.titleLarge.copyWith(color: colors.surface, fontWeight: FontWeight.w700)),
                Text(myTrack, style: AppTextStyles.labelSmall.copyWith(color: colors.surface.withValues(alpha: 0.7))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
