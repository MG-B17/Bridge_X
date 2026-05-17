import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:flutter/material.dart';

class PasswordRequirements extends StatelessWidget {
  const PasswordRequirements({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: context.colors.info.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
        border: Border.all(color: context.colors.info.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outlined, color: context.colors.info, size: AppSpacing.lg),
          HorizontalSpacing(AppSpacing.md),
          Expanded(
            child: Text(
              AppStrings.passwordMinLength,
              style: AppTextStyles.bodyMedium.copyWith(
                color: context.colors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
