import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/theme_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';

class NoUserFoundedWidget extends StatelessWidget {
  const NoUserFoundedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: AppSpacing.width14),
      child: Column(
        children: [
          Center(
            child: Icon(
              Icons.no_accounts_rounded,
              size: AppSpacing.fontSize90,
              color: context.colors.primary,
            ),
          ),
          VerticalSpacing(AppSpacing.height10),
          Text(
            AppStrings.noUserFound,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge.copyWith(
              color: context.colors.textPrimary,
              fontWeight: FontWeight.w700
            ),
          ),
          VerticalSpacing(AppSpacing.height10),
          Text(
            AppStrings.noUserFoundSubTittle,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: context.colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
