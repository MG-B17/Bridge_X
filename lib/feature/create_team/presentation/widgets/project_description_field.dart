import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectDescriptionField extends StatelessWidget {
  const ProjectDescriptionField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.projectDescription,
          style: text.labelMedium?.copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        VerticalSpacing(6.h),
        TextFormField(
          controller: controller,
          maxLines: 5,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          style: text.bodyMedium?.copyWith(color: colors.textPrimary),
          decoration: InputDecoration(
            hintText: AppStrings.describeProjectHint,
            hintStyle: text.bodyMedium?.copyWith(color: colors.textHint),
            filled: true,
            fillColor: colors.surface,
            contentPadding: EdgeInsets.symmetric(
              vertical: 14.h,
              horizontal: 16.w,
            ),
            border: _border(colors.divider),
            enabledBorder: _border(colors.divider),
            focusedBorder: _border(colors.primary, width: 1.5),
            errorBorder: _border(colors.error),
            focusedErrorBorder: _border(colors.error, width: 1.5),
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
