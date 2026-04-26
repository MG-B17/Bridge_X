import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/h_space.dart';
import '../../../../core/widgets/v_space.dart';
import '../../../../core/theme/app_color_scheme.dart';

class ProtectionBanner extends StatelessWidget {
  const ProtectionBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.spacing.xl),
      decoration: BoxDecoration(
        gradient: AppColorScheme.gradient,
        borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.bridgeXProtection,
                  style: context.displayLarge.copyWith(
                    color: Colors.white,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                VSpace(context.spacing.xs),
                Text(
                  AppStrings.bridgeXProtectionDesc,
                  style: context.bodyMedium.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          HSpace(context.spacing.md),
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.verified_user_rounded,
              color: Colors.white.withValues(alpha: 0.9),
              size: 26.w,
            ),
          ),
        ],
      ),
    );
  }
}

class SecurityMenuItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final bool showChevron;
  final bool showDivider;
  final VoidCallback? onTap;

  const SecurityMenuItem({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    this.showChevron = false,
    this.showDivider = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: context.spacing.md,
              horizontal: context.spacing.md,
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius:
                        BorderRadius.circular(context.spacing.radiusCard),
                  ),
                  child: Icon(icon, color: iconColor, size: 20.w),
                ),
                HSpace(context.spacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: context.bodyLarge.copyWith(
                          fontWeight: FontWeight.w700,
                          color: context.colors.textPrimary,
                        ),
                      ),
                      if (subtitle != null) ...[
                        SizedBox(height: 2.h),
                        Text(
                          subtitle!,
                          style: context.labelSmall.copyWith(
                            color: context.colors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (showChevron)
                  Icon(Icons.chevron_right_rounded,
                      color: context.colors.textHint, size: 24.w),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            color: context.colors.divider,
            indent: context.spacing.md,
            endIndent: context.spacing.md,
          ),
      ],
    );
  }
}

class DangerZoneCard extends StatelessWidget {
  final VoidCallback? onTap;

  const DangerZoneCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.spacing.md,
          vertical: context.spacing.lg,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFFEF2F2),
          borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
          border: Border.all(color: const Color(0xFFFECACA)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444),
                borderRadius:
                    BorderRadius.circular(context.spacing.radiusCard),
              ),
              child: Icon(Icons.delete_outline_rounded,
                  color: Colors.white, size: 20.w),
            ),
            HSpace(context.spacing.md),
            Expanded(
              child: Text(
                AppStrings.deleteAccount,
                style: context.bodyLarge.copyWith(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFEF4444),
                ),
              ),
            ),
            Icon(Icons.priority_high_rounded,
                color: const Color(0xFFEF4444), size: 22.w),
          ],
        ),
      ),
    );
  }
}

class PrivacyDisclaimerCard extends StatelessWidget {
  const PrivacyDisclaimerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.spacing.lg),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
        border: Border.all(
          color: context.colors.divider,
          style: BorderStyle.solid,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: 18.w,
            color: context.colors.textSecondary,
          ),
          HSpace(context.spacing.sm),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: context.bodyMedium.copyWith(
                  color: context.colors.textSecondary,
                  height: 1.5,
                ),
                children: [
                  TextSpan(text: AppStrings.privacyDisclaimer),
                  TextSpan(
                    text: AppStrings.termsOfService,
                    style: context.bodyMedium.copyWith(
                      color: context.colors.primary,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                      decorationColor: context.colors.primary,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
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

class SecuritySectionHeader extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? iconColor;

  const SecuritySectionHeader({
    super.key,
    required this.label,
    required this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.w,
          color: iconColor ?? context.colors.textSecondary,
        ),
        HSpace(context.spacing.xs),
        Text(
          label.toUpperCase(),
          style: context.labelSmall.copyWith(
            color: iconColor ?? context.colors.textSecondary,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}
