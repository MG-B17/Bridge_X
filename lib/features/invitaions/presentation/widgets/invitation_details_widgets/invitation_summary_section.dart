import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/extensions.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/invitaions/domain/entities/project_invitation_entity.dart';
import 'package:bridge_x/features/invitaions/presentation/utils/invitaions_strings.dart';
import 'package:flutter/material.dart';

class InvitationSummarySection extends StatelessWidget {
  final ProjectInvitationEntity invitation;

  const InvitationSummarySection({
    super.key,
    required this.invitation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.spacing10,
                vertical: AppSpacing.spacing4,
              ),
              decoration: BoxDecoration(
                color: context.appColors.primaryLight.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(AppSpacing.radius6),
              ),
              child: Text(
                '${invitation.projectType} • ${invitation.membersCount} Members',
                style: AppTextStyles.labelSmall.copyWith(
                  color: context.appColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.spacing8,
                vertical: AppSpacing.spacing4,
              ),
              decoration: BoxDecoration(
                color: context.appColors.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radius6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: AppSpacing.spacing4 - AppSpacing.spacing2,
                    backgroundColor: context.appColors.success,
                  ),
                  HorizontalSpacing(AppSpacing.spacing4),
                  Text(
                    invitation.status,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: context.appColors.success,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        VerticalSpacing(AppSpacing.spacing16),
        Text(
          invitation.projectName,
          style: AppTextStyles.displayLarge.copyWith(
            color: context.appColors.textPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
        VerticalSpacing(AppSpacing.spacing6),
        Text(
          '${InvitaionsStrings.createdBy}${invitation.creatorName}',
          style: AppTextStyles.labelSmall.copyWith(
            color: context.appColors.textSecondary,
          ),
        ),
        VerticalSpacing(AppSpacing.spacing20),
        Divider(color: context.appColors.divider.withValues(alpha: 0.5)),
        VerticalSpacing(AppSpacing.spacing20),
        Text(
          InvitaionsStrings.projectOverview,
          style: AppTextStyles.titleLarge.copyWith(
            color: context.appColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        VerticalSpacing(AppSpacing.spacing8),
        Text(
          invitation.description,
          style: AppTextStyles.bodyMedium.copyWith(
            color: context.appColors.textSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
