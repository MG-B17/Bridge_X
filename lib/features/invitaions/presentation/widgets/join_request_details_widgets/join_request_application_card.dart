import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/extensions.dart';
import 'package:bridge_x/features/invitaions/domain/entities/join_request_entity.dart';
import 'package:flutter/material.dart';

class JoinRequestApplicationCard extends StatelessWidget {
  final JoinRequestEntity joinRequest;

  const JoinRequestApplicationCard({
    super.key,
    required this.joinRequest,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.spacing16),
      decoration: BoxDecoration(
        color: context.appColors.primaryLight.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppSpacing.radius12),
        border: Border.all(
          color: context.appColors.divider.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Application Date',
            style: AppTextStyles.bodyMedium.copyWith(
              color: context.appColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            joinRequest.appliedTimeAgo,
            style: AppTextStyles.bodyMedium.copyWith(
              color: context.appColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
