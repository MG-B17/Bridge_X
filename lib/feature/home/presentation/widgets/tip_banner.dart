import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TipBanner extends StatelessWidget {
  const TipBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 14.h,
      ),
      decoration: BoxDecoration(
        color: context.colors.primaryLight.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        border: Border.all(
          color: context.colors.primary.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        children: [
          Text('💡', style: TextStyle(fontSize: 18.sp)),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              AppStrings.tipBanner,
              style: AppTextStyles.bodyMedium.copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
