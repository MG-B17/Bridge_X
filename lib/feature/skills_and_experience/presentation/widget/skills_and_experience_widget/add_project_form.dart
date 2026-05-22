import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import 'dashed_border_painter.dart';

class AddProjectForm extends StatelessWidget {
  const AddProjectForm({
    super.key,
    required this.projectNameController,
    required this.roleController,
    required this.onConfirm,
    required this.onCancel,
  });

  final TextEditingController projectNameController;
  final TextEditingController roleController;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(
        color: context.colors.primary,
        borderRadius: AppSpacing.radiusCard,
      ),
      child: Container(
        padding: EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.projectName.toUpperCase(),
              style: context.textTheme.labelSmall?.copyWith(
                color: context.colors.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
            VerticalSpacing(AppSpacing.xs),
            TextFormField(
              controller: projectNameController,
              style: context.textTheme.bodyMedium?.copyWith(color: context.colors.textPrimary),
              decoration: InputDecoration(
                hintText: AppStrings.projectNameHint,
                hintStyle: context.textTheme.bodyMedium?.copyWith(color: context.colors.textHint),
                filled: true,
                fillColor: context.colors.surface,
                contentPadding: EdgeInsets.symmetric(
                  vertical: AppSpacing.md,
                  horizontal: AppSpacing.md,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
                  borderSide: BorderSide(color: context.colors.divider),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
                  borderSide: BorderSide(color: context.colors.divider),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
                  borderSide: BorderSide(color: context.colors.primary, width: 1.5.w),
                ),
              ),
            ),
            VerticalSpacing(AppSpacing.md),
            Text(
              AppStrings.role.toUpperCase(),
              style: context.textTheme.labelSmall?.copyWith(
                color: context.colors.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
            VerticalSpacing(AppSpacing.xs),
            TextFormField(
              controller: roleController,
              style: context.textTheme.bodyMedium?.copyWith(color: context.colors.textPrimary),
              decoration: InputDecoration(
                hintText: AppStrings.roleHint,
                hintStyle: context.textTheme.bodyMedium?.copyWith(color: context.colors.textHint),
                filled: true,
                fillColor: context.colors.surface,
                contentPadding: EdgeInsets.symmetric(
                  vertical: AppSpacing.md,
                  horizontal: AppSpacing.md,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
                  borderSide: BorderSide(color: context.colors.divider),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
                  borderSide: BorderSide(color: context.colors.divider),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
                  borderSide: BorderSide(color: context.colors.primary, width: 1.5.w),
                ),
              ),
            ),
            VerticalSpacing(AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: onConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.sm,
                    ),
                  ),
                  child: Text(
                    AppStrings.confirmAdd,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                HorizontalSpacing(AppSpacing.md),
                TextButton(
                  onPressed: onCancel,
                  child: Text(
                    AppStrings.cancel,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
