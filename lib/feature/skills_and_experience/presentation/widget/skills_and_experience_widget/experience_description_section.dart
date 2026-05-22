import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';

class ExperienceDescriptionSection extends StatelessWidget {
  const ExperienceDescriptionSection({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.business_center_outlined,
              color: context.colors.textPrimary,
              size: 20,
            ),
            HorizontalSpacing(AppSpacing.sm),
            Text(
              AppStrings.experience,
              style: context.textTheme.titleMedium?.copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        VerticalSpacing(AppSpacing.sm),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
            border: Border.all(color: context.colors.divider),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: TextFormField(
            controller: controller,
            maxLines: 8,
            minLines: 5,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colors.textSecondary,
              height: 1.5,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }
}
