import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/extensions.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';

class RequestsCenterEmptyState extends StatelessWidget {
  final String message;

  const RequestsCenterEmptyState({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: AppSpacing.section),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.folder_open_rounded,
            size: AppSpacing.spacing48,
            color: context.appColors.textSecondary.withValues(alpha: 0.5),
          ),
          VerticalSpacing(AppSpacing.spacing12),
          Text(
            message,
            style: AppTextStyles.bodyMedium.copyWith(
              color: context.appColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
