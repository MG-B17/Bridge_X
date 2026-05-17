import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';

class ProtectionCard extends StatelessWidget {
  const ProtectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: context.colors.secondary, // deepBlue
        borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -20,
            bottom: -30,
            child: Icon(
              Icons.gpp_good,
              size: 150,
              color: context.colors.primary.withValues(alpha: 0.3),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.bridgeXProtection,
                style: AppTextStyles.displayLarge.copyWith(
                  color: context.colors.surface,
                  fontWeight: FontWeight.w800,
                ),
              ),
              VerticalSpacing(AppSpacing.sm),
              Padding(
                padding: const EdgeInsets.only(right: 60),
                child: Text(
                  AppStrings.bridgeXProtectionDesc,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: context.colors.surface.withValues(alpha: 0.8),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
