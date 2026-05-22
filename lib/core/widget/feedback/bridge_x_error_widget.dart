import 'package:bridge_x/core/extensions/theme_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_colors.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/extensions.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';

class BridgeXErrorWidget extends StatelessWidget {
  const BridgeXErrorWidget({super.key,required this.errorMessage,required this.errorTittle, required this.refreshButtonTap});
  final String errorMessage; 
  final String errorTittle; 
  final VoidCallback refreshButtonTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.spacing24),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding:EdgeInsets.all(AppSpacing.spacing16),
              decoration: BoxDecoration(
                color: context.appColors.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child:Icon(Icons.error_outline, color: context.appColors.error, size: AppSpacing.height40),
            ),
            VerticalSpacing(AppSpacing.height20),
            Text(
              errorTittle,
              style: AppTextStyles.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colors.textPrimary,
              ),
            ),
            VerticalSpacing(AppSpacing.height8),
            Text(
              errorMessage,
              style: AppTextStyles.bodyMedium.copyWith(color: context.colors.textSecondary),
              textAlign: TextAlign.center,
            ),
            VerticalSpacing(AppSpacing.height32),
            ElevatedButton.icon(
              onPressed: refreshButtonTap,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radius12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
