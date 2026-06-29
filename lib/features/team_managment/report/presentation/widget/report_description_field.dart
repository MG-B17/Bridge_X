import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:flutter/material.dart';

class ReportDescriptionField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const ReportDescriptionField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 3,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: AppStrings.describeTheIssue,
        hintStyle: AppTextStyles.bodyMedium.copyWith(color: context.colors.textHint),
        filled: true,
        fillColor: context.colors.scaffoldBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radius12),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.all(AppSpacing.spacing16),
      ),
    );
  }
}
