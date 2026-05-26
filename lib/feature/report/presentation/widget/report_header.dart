import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportHeader extends StatelessWidget {
  final VoidCallback onClose;

  const ReportHeader({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: context.colors.divider,
              borderRadius: BorderRadius.circular(AppSpacing.radius2),
            ),
          ),
        ),
        VerticalSpacing(AppSpacing.spacing16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.reportUser,
              style: AppTextStyles.headlineMedium.copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: onClose,
              child: Icon(Icons.close, color: context.colors.textSecondary),
            ),
          ],
        ),
      ],
    );
  }
}
