import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:flutter/material.dart';

class SettingsMenuItem extends StatelessWidget {
  const SettingsMenuItem({
    required this.label,
    required this.icon,
    required this.onTap,
    super.key,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.spacing20,
          vertical: AppSpacing.spacing24,
        ),
        decoration: BoxDecoration(
          color: context.colors.primary.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(AppSpacing.radius16),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: context.colors.indigo,
              size: AppSpacing.fontSize24,
            ),
            HorizontalSpacing(AppSpacing.spacing16),
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.titleMedium.copyWith(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: AppSpacing.fontSize16,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: context.colors.textSecondary,
              size: AppSpacing.fontSize20,
            ),
          ],
        ),
      ),
    );
  }
}
