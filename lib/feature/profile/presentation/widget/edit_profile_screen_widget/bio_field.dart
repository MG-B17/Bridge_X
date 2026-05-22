import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/inputs/bridge_x_text_form_field.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BioField extends StatelessWidget {
  const BioField({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BridgeXTextFormField(
          label: AppStrings.bio,
          hint: AppStrings.bioHint,
          controller: controller,
          maxLines: 5,
          maxLength: 250,
        ),
        VerticalSpacing(AppSpacing.xs),
        Text(
          AppStrings.bioMaxCharsHint,
          style: AppTextStyles.labelSmall.copyWith(
            color: context.colors.textSecondary,
            fontStyle: FontStyle.italic,
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }
}
