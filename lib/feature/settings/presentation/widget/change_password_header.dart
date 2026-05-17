import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordHeader extends StatelessWidget {
  const ChangePasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          child: Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: context.colors.surface,
              shape: BoxShape.circle,
              boxShadow: AppSpacing.subtleShadow,
            ),
            child: Icon(Icons.arrow_back, size: 20.w, color: context.colors.textPrimary),
          ),
        ),
        SizedBox(width: AppSpacing.lg),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Change Password',
              style: AppTextStyles.headlineMedium.copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            VerticalSpacing(AppSpacing.xs),
            Text(
              'Security Update',
              style: AppTextStyles.bodyMedium.copyWith(color: context.colors.textSecondary),
            ),
          ],
        ),
      ],
    );
  }
}
