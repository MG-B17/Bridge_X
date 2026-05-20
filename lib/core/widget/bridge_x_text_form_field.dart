import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';

class BridgeXTextFormField extends StatelessWidget {
  const BridgeXTextFormField({
    super.key,
    this.label,
    required this.hint,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.prefixIconWidget,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.textInputAction,
    this.autofillHints,
    this.maxLines = 1,
    this.maxLength,
    this.fillColor,
    this.contentPadding,
    this.borderRadius,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.hintStyle,
    this.style,
    this.onFieldSubmitted,
    this.textAlignVertical,
    this.isDense,
    this.minLines,
  });

  final String? label;
  final String hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final Widget? prefixIconWidget;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final int? maxLines;
  final int? maxLength;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;
  final double? borderRadius;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final ValueChanged<String>? onFieldSubmitted;
  final TextAlignVertical? textAlignVertical;
  final bool? isDense;
  final int? minLines;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textTheme;

    final defaultBorderRadius = borderRadius ?? AppSpacing.radius12;

    final textField = TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      enabled: enabled,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      textInputAction: textInputAction,
      autofillHints: autofillHints,
      style: style ?? text.bodyMedium?.copyWith(color: colors.textPrimary),
      textAlignVertical: textAlignVertical ?? TextAlignVertical.center,
      decoration: InputDecoration(
        isDense: isDense,
        hintText: hint,
        hintStyle: hintStyle ?? text.bodyMedium?.copyWith(color: colors.textHint),
        prefixIcon: prefixIconWidget ??
            (prefixIcon != null
                ? Icon(
                    prefixIcon,
                    color: colors.textHint,
                    size: AppSpacing.fontSize20,
                  )
                : null),
        suffixIcon: suffixIcon,
        filled: fillColor != Colors.transparent,
        fillColor: fillColor ?? colors.surface,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              vertical: AppSpacing.height14,
              horizontal: AppSpacing.spacing16,
            ),
        border: border ?? _border(colors.divider, defaultBorderRadius),
        enabledBorder: enabledBorder ?? _border(colors.divider, defaultBorderRadius),
        focusedBorder: focusedBorder ?? _border(colors.primary, defaultBorderRadius, width: 1.5),
        errorBorder: border ?? _border(colors.error, defaultBorderRadius),
        focusedErrorBorder: focusedBorder ?? _border(colors.error, defaultBorderRadius, width: 1.5),
        disabledBorder: border ?? _border(colors.divider, defaultBorderRadius),
      ),
    );

    if (label == null) {
      return textField;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label!,
          style: text.labelMedium?.copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        VerticalSpacing(AppSpacing.height6),
        textField,
      ],
    );
  }

  OutlineInputBorder _border(Color color, double radius, {double width = 1.2}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
