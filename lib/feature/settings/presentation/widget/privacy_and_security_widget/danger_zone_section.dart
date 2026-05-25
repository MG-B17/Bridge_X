import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';

class DangerZoneSection extends StatelessWidget {
  const DangerZoneSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              size: AppSpacing.fontSize18,
              color: context.colors.error,
            ),
            HorizontalSpacing(AppSpacing.spacing4),
            Text(
              AppStrings.dangerZone.toUpperCase(),
              style: AppTextStyles.labelSmall.copyWith(
                color: context.colors.error,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        VerticalSpacing(AppSpacing.spacing16),
        Container(
          decoration: BoxDecoration(
            color: context.colors.error.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(AppSpacing.radius12),
            border: Border.all(color: context.colors.error.withValues(alpha: 0.3)),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSpacing.spacing20,
              vertical: AppSpacing.spacing4,
            ),
            leading: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: context.colors.error.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(AppSpacing.radius8),
              ),
              child: Icon(Icons.delete_outline, color: context.colors.error, size: 22),
            ),
            title: Text(
              AppStrings.deleteAccount,
              style: AppTextStyles.titleMedium.copyWith(
                color: context.colors.error,
                fontWeight: FontWeight.w800,
              ),
            ),
            trailing: Icon(Icons.error_outline, color: context.colors.error.withValues(alpha: 0.7)),
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
