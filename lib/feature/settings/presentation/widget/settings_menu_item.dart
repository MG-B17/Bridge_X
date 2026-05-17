import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.xl,
        ),
        decoration: BoxDecoration(
          color: context.colors.primary.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: context.colors.indigo,
              size: 24.w,
            ),
            HorizontalSpacing(AppSpacing.md),
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.titleMedium.copyWith(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: context.colors.textSecondary,
              size: 20.w,
            ),
          ],
        ),
      ),
    );
  }
}
