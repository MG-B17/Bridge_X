import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:flutter/material.dart';

class MultiCategoryInfoBanner extends StatelessWidget {
  const MultiCategoryInfoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: EdgeInsets.all(AppSpacing.spacing16),
      decoration: BoxDecoration(
        color: colors.primaryLight.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(AppSpacing.radius12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: AppSpacing.spacing28,
            height: AppSpacing.spacing28,
            decoration: BoxDecoration(
              color: colors.error.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.info_outline_rounded,
              color: colors.error,
              size: AppSpacing.fontSize16,
            ),
          ),
          HorizontalSpacing(AppSpacing.spacing8),
          Expanded(
            child: Text(
              AppStrings.multiCategoryHint,
              style: AppTextStyles.labelSmall.copyWith(
                color: colors.textSecondary,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
