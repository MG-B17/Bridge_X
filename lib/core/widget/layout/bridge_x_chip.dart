import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:flutter/material.dart';

class BridgeXChip extends StatelessWidget {
  const BridgeXChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onTap,
    this.onRemove,
    this.showCheckmark = false,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.borderColor,
    this.selectedBorderColor,
    this.textColor,
    this.selectedTextColor,
    this.borderRadius,
    this.boxShadow,
    this.padding,
    this.textStyle,
  });

  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;
  final bool showCheckmark;
  final Color? backgroundColor;
  final Color? selectedBackgroundColor;
  final Color? borderColor;
  final Color? selectedBorderColor;
  final Color? textColor;
  final Color? selectedTextColor;
  final double? borderRadius;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    // Resolve colors with default fallbacks matching BridgeX theme
    final Color resolvedBg = isSelected
        ? (selectedBackgroundColor ?? colors.primaryLight.withValues(alpha: 0.3))
        : (backgroundColor ?? colors.surface);

    final Color resolvedBorder = isSelected
        ? (selectedBorderColor ?? colors.primary)
        : (borderColor ?? colors.divider);

    final Color resolvedText = isSelected
        ? (selectedTextColor ?? colors.primary)
        : (textColor ?? colors.textPrimary);

    final Widget chipContent = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: AppSpacing.spacing16,
            vertical: AppSpacing.spacing8,
          ),
      decoration: BoxDecoration(
        color: resolvedBg,
        borderRadius: BorderRadius.circular(borderRadius ?? AppSpacing.radius32),
        border: Border.all(
          color: resolvedBorder,
          width: isSelected ? 1.6 : 1.2,
        ),
        boxShadow: isSelected ? boxShadow : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isSelected && showCheckmark) ...[
            Icon(
              Icons.check,
              color: resolvedText,
              size: AppSpacing.fontSize16,
            ),
            HorizontalSpacing(AppSpacing.spacing4),
          ],
          Text(
            label,
            style: (textStyle ?? AppTextStyles.titleMedium).copyWith(
              color: resolvedText,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
          if (onRemove != null) ...[
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
        ],
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: chipContent,
      );
    }

    return chipContent;
  }
}
