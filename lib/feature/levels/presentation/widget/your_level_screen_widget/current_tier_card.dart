import 'package:bridge_x/core/utils/app_shadow.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrentTierCard extends StatelessWidget {
  const CurrentTierCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.colors.secondary, 
        borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
        boxShadow: AppShadow.subtle,
      ),
      child: Stack(
        children: [
          // Background faint icon
          Positioned(
            top: -10.h,
            right: -10.w,
            child: Icon(
              Icons.workspace_premium, // Or any medal/badge icon
              size: 100.w,
              color: context.colors.surface.withValues(alpha: 0.1),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.currentTier,
                style: AppTextStyles.labelSmall.copyWith(
                  color: context.colors.surface.withValues(alpha: 0.8),
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              VerticalSpacing(AppSpacing.xs),
              Text(
                AppStrings.beginnerSilver,
                style: AppTextStyles.displayLarge.copyWith(
                  color: context.colors.surface,
                  fontWeight: FontWeight.w800,
                ),
              ),
              VerticalSpacing(AppSpacing.xl),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.progressToGold,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: context.colors.surface.withValues(alpha: 0.9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '70%',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: context.colors.surface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              VerticalSpacing(8.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
                child: LinearProgressIndicator(
                  value: 0.7,
                  minHeight: 8.h,
                  backgroundColor: context.colors.surface.withValues(alpha: 0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(context.colors.primaryLight),
                ),
              ),
              VerticalSpacing(AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      AppStrings.nextTierRequirement,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: context.colors.surface.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.outlined_flag,
                    color: context.colors.surface.withValues(alpha: 0.7),
                    size: 16.w,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

