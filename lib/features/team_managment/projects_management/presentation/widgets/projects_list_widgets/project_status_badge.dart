import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:flutter/material.dart';

class ProjectStatusBadge extends StatelessWidget {
  const ProjectStatusBadge({
    super.key,
    required this.label,
    required this.isCompleted,
    this.showIcon = false,
    required this.textColor,
    required this.bgColor
  });

  final String label;
  final bool isCompleted;
  final bool showIcon;
  final Color textColor ;
  final Color bgColor;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.spacing12,
        vertical: AppSpacing.height5,
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
              size: AppSpacing.fontSize12,
            ),
            HorizontalSpacing(AppSpacing.xs),
          ],
          Text(
            label.toUpperCase(),
            style: AppTextStyles.labelSmall.copyWith(
              color: textColor,
              fontWeight: FontWeight.w700,
              fontSize: AppSpacing.fontSize10,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
