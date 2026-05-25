import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UsernameField extends StatelessWidget {
  const UsernameField({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.username,
          style: context.textTheme.labelMedium?.copyWith(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        VerticalSpacing(6),
        TextFormField(
          controller: controller,
          style: context.textTheme.bodyMedium?.copyWith(color: context.colors.textPrimary),
          decoration: InputDecoration(
            hintText: AppStrings.usernameHint,
            hintStyle: context.textTheme.bodyMedium?.copyWith(color: context.colors.textHint),
            filled: true,
            fillColor: context.colors.surface,
            contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
            border: _buildBorder(context.colors.divider),
            enabledBorder: _buildBorder(context.colors.divider),
            focusedBorder: _buildBorder(context.colors.primary, width: 1.5),
            suffixIcon: Padding(
              padding: EdgeInsets.only(right: AppSpacing.md),
              child: Center(
                widthFactor: 1, // Ensures suffix icon doesn't stretch
                child: Text(
                  AppStrings.available,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: context.colors.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _buildBorder(Color color, {double width = 1.2}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
