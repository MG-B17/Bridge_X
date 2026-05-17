import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AccountSecuritySection extends StatelessWidget {
  const AccountSecuritySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.shield_outlined,
              size: 18.sp,
              color: context.colors.textSecondary,
            ),
            HorizontalSpacing(AppSpacing.xs),
            Text(
              AppStrings.accountSecurity,
              style: AppTextStyles.labelSmall.copyWith(
                color: context.colors.textSecondary,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        VerticalSpacing(AppSpacing.md),
        Container(
          decoration: BoxDecoration(
            color: context.colors.primary.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
            border: Border.all(color: context.colors.divider),
          ),
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xs),
                leading: Icon(Icons.key_outlined, color: context.colors.textPrimary),
                title: Text(
                  AppStrings.changePassword,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: context.colors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                trailing: Icon(Icons.chevron_right, color: context.colors.textSecondary),
                onTap: () {
                  context.goNamed(BridegeXRouteNames.changePassword);
                },
              ),
              Divider(height: 1, thickness: 1, color: context.colors.divider, indent: AppSpacing.lg, endIndent: AppSpacing.lg),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xs),
                leading: Icon(Icons.alternate_email, color: context.colors.textPrimary),
                title: Text(
                  AppStrings.email,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: context.colors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  'ahmed.t@bridgex.com',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: context.colors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
