import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    required this.label,
    required this.icon,
    required this.onTap,
    this.isDestructive = false,
    this.badgeCount,
    super.key,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDestructive;
  final int? badgeCount;

  @override
  Widget build(BuildContext context) {
    final iconColor = isDestructive ? context.colors.error : context.colors.textPrimary;
    final iconBgColor = isDestructive ? context.colors.error.withValues(alpha: 0.1) : context.colors.primary.withValues(alpha: 0.05);
    final textColor = isDestructive ? context.colors.error : context.colors.textPrimary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Icon with tinted background
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: iconBgColor,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
                    ),
                    child: Icon(icon, size: 20.w, color: iconColor),
                  ),
                  HorizontalSpacing(AppSpacing.md),
                  Text(
                    label, 
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  if (badgeCount != null)
                    Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: context.colors.error,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        badgeCount.toString(),
                        style: AppTextStyles.labelSmall.copyWith(
                          color: context.colors.surface,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  if (badgeCount != null) HorizontalSpacing(AppSpacing.xs),
                  Icon(
                    Icons.chevron_right_outlined,
                    size: 20.w,
                    color: context.colors.textHint,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
