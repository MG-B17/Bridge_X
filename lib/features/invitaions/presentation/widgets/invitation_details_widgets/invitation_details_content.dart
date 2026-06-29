import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/extensions.dart';
import 'package:bridge_x/core/widget/layout/bridge_x_screen_header.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/invitaions/domain/entities/project_invitation_entity.dart';
import 'package:bridge_x/features/invitaions/presentation/utils/invitaions_strings.dart';
import 'package:bridge_x/features/invitaions/presentation/widgets/avatar_stack.dart';
import 'package:bridge_x/features/invitaions/presentation/widgets/invitation_details_widgets/invitation_leader_role_section.dart';
import 'package:bridge_x/features/invitaions/presentation/widgets/invitation_details_widgets/invitation_summary_section.dart';
import 'package:flutter/material.dart';

class InvitationDetailsContent extends StatelessWidget {
  final ProjectInvitationEntity invitation;

  const InvitationDetailsContent({
    super.key,
    required this.invitation,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.spacing20,
        vertical: AppSpacing.spacing20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BridgeXScreenHeader(title: InvitaionsStrings.requestReview),
          VerticalSpacing(AppSpacing.spacing24),
          InvitationSummarySection(invitation: invitation),
          VerticalSpacing(AppSpacing.spacing24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                InvitaionsStrings.teamMembers,
                style: AppTextStyles.titleLarge.copyWith(
                  color: context.appColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                InvitaionsStrings.viewAll,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: context.appColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          VerticalSpacing(AppSpacing.spacing10),
          AvatarStack(
            avatarUrls: invitation.memberAvatars,
            avatarSize: AppSpacing.spacing36,
          ),
          VerticalSpacing(AppSpacing.spacing30),
          InvitationLeaderRoleSection(invitation: invitation),
        ],
      ),
    );
  }
}
