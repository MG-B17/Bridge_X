import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:flutter/material.dart';

class RoleChip extends StatelessWidget {
  const RoleChip({super.key, required this.label, required this.onRemove});
  final String label;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.spacing10,
        vertical: AppSpacing.height6,
      ),
      decoration: BoxDecoration(
        color: colors.teal.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppSpacing.radius12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: colors.ongoingText,
              fontWeight: FontWeight.w600,
            ),
          ),
          HorizontalSpacing(AppSpacing.spacing4),
          GestureDetector(
            onTap: onRemove,
            child: Icon(
              Icons.close_rounded,
              size: AppSpacing.fontSize14,
              color: colors.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
