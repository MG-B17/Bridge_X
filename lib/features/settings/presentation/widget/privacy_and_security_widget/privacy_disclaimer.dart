import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:flutter/material.dart';

class PrivacyDisclaimer extends StatelessWidget {
  const PrivacyDisclaimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.spacing20),
      decoration: BoxDecoration(
        color: context.colors.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppSpacing.radius12),
        border: Border.all(
          color: context.colors.divider,
        ), 
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            size: 22,
            color: context.colors.textPrimary,
          ),
          HorizontalSpacing(AppSpacing.spacing16),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: AppStrings.privacyDisclaimer,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: context.colors.textSecondary,
                  height: 1.6,
                ),
                children: [
                  TextSpan(
                    text: AppStrings.termsOfService,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: context.colors.textPrimary,
                      fontWeight: FontWeight.w800,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const TextSpan(text: '.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
