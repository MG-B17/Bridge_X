import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/extensions.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/invitaions/domain/entities/project_invitation_entity.dart';
import 'package:bridge_x/features/invitaions/presentation/utils/invitaions_strings.dart';
import 'package:flutter/material.dart';

class InvitationLeaderRoleSection extends StatelessWidget {
  final ProjectInvitationEntity invitation;

  const InvitationLeaderRoleSection({
    super.key,
    required this.invitation,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _InfoCard(
            title: InvitaionsStrings.leader,
            value: invitation.leaderName,
          ),
        ),
        HorizontalSpacing(AppSpacing.spacing16),
        Expanded(
          child: _InfoCard(
            title: InvitaionsStrings.role,
            value: invitation.roleName,
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;

  const _InfoCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.spacing12),
      decoration: BoxDecoration(
        color: context.appColors.primaryLight.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppSpacing.radius12),
        border: Border.all(
          color: context.appColors.primary.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.labelSmall.copyWith(
              color: context.appColors.textSecondary,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          VerticalSpacing(AppSpacing.spacing6),
          Text(
            value,
            style: AppTextStyles.titleMedium.copyWith(
              color: context.appColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
