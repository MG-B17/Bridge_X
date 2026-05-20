import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A reusable status badge used inside project cards.
///
/// [isCompleted] controls the color scheme:
/// - `true` → green (completed) variant
/// - `false` → pink/ongoing variant
class ProjectStatusBadge extends StatelessWidget {
  const ProjectStatusBadge({
    super.key,
    required this.label,
    required this.isCompleted,
    this.showIcon = false,
  });

  final String label;
  final bool isCompleted;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final bgColor = isCompleted ? colors.completedBg : colors.ongoingBg;
    final textColor = isCompleted
        ? colors.completedText
        : const Color(0xFFE11D48); // rose-600 for ongoing

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 6.h,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            Icon(
              Icons.check_circle,
              color: textColor,
              size: 14.sp,
            ),
            HorizontalSpacing(AppSpacing.xs),
          ],
          Text(
            label.toUpperCase(),
            style: AppTextStyles.labelSmall.copyWith(
              color: textColor,
              fontWeight: FontWeight.w700,
              fontSize: 11.sp,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
