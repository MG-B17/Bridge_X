import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportActions extends StatelessWidget {
  final bool canSubmit;
  final bool isSubmitting;
  final VoidCallback onSubmit;
  final VoidCallback onCancel;

  const ReportActions({
    super.key,
    required this.canSubmit,
    required this.isSubmitting,
    required this.onSubmit,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: isSubmitting || !canSubmit ? null : onSubmit,
          child: Container(
            width: double.infinity,
            height: AppSpacing.height50,
            decoration: BoxDecoration(
              color: canSubmit
                  ? context.colors.error
                  : context.colors.error.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(AppSpacing.radius12),
            ),
            child: Center(
              child: isSubmitting
                  ? SizedBox(
                      height: 22.w,
                      width: 22.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: context.colors.surface,
                      ),
                    )
                  : Text(
                      AppStrings.submitReport,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: context.colors.surface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ),
        VerticalSpacing(AppSpacing.spacing12),
        GestureDetector(
          onTap: onCancel,
          child: Container(
            width: double.infinity,
            height: AppSpacing.height50,
            decoration: BoxDecoration(
              color: context.colors.scaffoldBg,
              borderRadius: BorderRadius.circular(AppSpacing.radius12),
            ),
            child: Center(
              child: Text(
                AppStrings.cancel,
                style: AppTextStyles.titleMedium.copyWith(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
