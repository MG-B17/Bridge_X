import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.spacing18,
          vertical: AppSpacing.height12,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? colors.primaryLight.withValues(alpha: 0.3)
              : colors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radius32),
          border: Border.all(
            color: isSelected ? colors.primary : colors.divider,
            width: isSelected ? 1.6 : 1.2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected) ...[
              Icon(
                Icons.check,
                color: colors.primary,
                size: AppSpacing.fontSize16,
              ),
              HorizontalSpacing(AppSpacing.spacing4),
            ],
            Text(
              label,
              style: AppTextStyles.titleMedium.copyWith(
                color: isSelected ? colors.primary : colors.textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
