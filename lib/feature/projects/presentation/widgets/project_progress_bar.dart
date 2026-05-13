import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Horizontal progress bar with a phase label and percentage display.
class ProjectProgressBar extends StatelessWidget {
  const ProjectProgressBar({
    super.key,
    required this.phase,
    required this.progress,
  });

  final String phase;

  /// A value between 0.0 and 1.0.
  final double progress;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final percentage = (progress * 100).toInt();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Phase label and percentage ──
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              phase,
              style: AppTextStyles.labelSmall.copyWith(
                color: colors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '$percentage%',
              style: AppTextStyles.labelSmall.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),

        // ── Bar track ──
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
          child: SizedBox(
            height: 6.h,
            child: Stack(
              children: [
                // Track background
                Container(
                  width: double.infinity,
                  color: colors.primaryLight.withValues(alpha: 0.5),
                ),
                // Filled progress
                FractionallySizedBox(
                  widthFactor: progress.clamp(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          colors.accent,
                          colors.accent.withValues(alpha: 0.7),
                        ],
                      ),
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusPill),
                    ),
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
