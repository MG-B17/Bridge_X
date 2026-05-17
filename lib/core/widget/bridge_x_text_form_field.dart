import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BridgeXTextFormField extends StatelessWidget {
  const BridgeXTextFormField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.textInputAction,
    this.autofillHints,
    this.maxLines = 1,
    this.maxLength,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final int? maxLines;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: text.labelMedium?.copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        VerticalSpacing(6.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          enabled: enabled,
          validator: validator,
          onChanged: onChanged,
          maxLines: maxLines,
          maxLength: maxLength,
          textInputAction: textInputAction,
          autofillHints: autofillHints,
          style: text.bodyMedium?.copyWith(color: colors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: text.bodyMedium?.copyWith(color: colors.textHint),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: colors.textHint, size: 20.sp)
                : null,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: colors.surface,
            contentPadding:
                EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
            border: _border(colors.divider),
            enabledBorder: _border(colors.divider),
            focusedBorder: _border(colors.primary, width: 1.5),
            errorBorder: _border(colors.error),
            focusedErrorBorder: _border(colors.error, width: 1.5),
            disabledBorder: _border(colors.divider),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border(Color color, {double width = 1.2}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
