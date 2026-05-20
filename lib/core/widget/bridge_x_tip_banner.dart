import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:flutter/material.dart';

class BridgeXTipBanner extends StatelessWidget {
  const BridgeXTipBanner({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.spacing16,
        vertical: AppSpacing.height14,
      ),
      decoration: BoxDecoration(
        color: context.colors.indigo.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppSpacing.radius12),
        border: Border.all(
          color: context.colors.primary.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        children: [
          Text('💡', style: TextStyle(fontSize: AppSpacing.fontSize18)),
          HorizontalSpacing(AppSpacing.spacing10),
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(
                color: context.colors.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
