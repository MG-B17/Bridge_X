import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_shadow.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';

class FocusImpactBanner extends StatelessWidget {
  const FocusImpactBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppSpacing.height160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radius24),
        boxShadow: AppShadow.card,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.radius24),
        child: Stack(
          children: [
            Image.asset(
              'assets/images/focus_impact_bg.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    context.colors.textPrimary.withValues(alpha: 0.75),
                    context.colors.textPrimary.withValues(alpha: 0.15),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(AppSpacing.spacing20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    AppStrings.focusOnImpact,
                    style: AppTextStyles.displayLarge.copyWith(
                      color: context.colors.surface,
                      fontSize: AppSpacing.fontSize20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  VerticalSpacing(AppSpacing.spacing4),
                  Text(
                    AppStrings.focusOnImpactDescription,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: context.colors.surface.withValues(alpha: 0.85),
                      fontSize: AppSpacing.fontSize14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
