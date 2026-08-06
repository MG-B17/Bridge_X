import 'package:bridge_x/core/theme/app_color_schema.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/extensions.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/invitaions/domain/entities/project_invitation_entity.dart';
import 'package:bridge_x/features/invitaions/presentation/utils/invitaions_strings.dart';
import 'package:bridge_x/features/invitaions/presentation/widgets/avatar_stack.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/navigation/route_constant/bridge_x_route_names.dart';
import '../../../../core/navigation/route_constant/bridge_x_route_paths.dart';

class InvitationCard extends StatelessWidget {
  final ProjectInvitationEntity invitation;
  final VoidCallback onReview;
  final VoidCallback? onOpenProject;

  const InvitationCard({
    super.key,
    required this.invitation,
    required this.onReview,
    this.onOpenProject,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSpacing.spacing16),
      padding: EdgeInsets.all(AppSpacing.spacing16),
      decoration: BoxDecoration(
        color: invitation.status.toLowerCase() == 'accepted'
            ? context.appColors.success.withValues(alpha: 0.08)
            : context.appColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radius16),
        border: Border.all(
          color: context.appColors.divider.withValues(alpha: 0.5),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
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
                  invitation.projectType,
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
                      radius: 3,
                      backgroundColor: context.appColors.success,
                    ),
                    const HorizontalSpacing(4),
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
          VerticalSpacing(AppSpacing.spacing12),
          Text(
            invitation.projectName,
            style: AppTextStyles.headlineSmall.copyWith(
              color: context.appColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          VerticalSpacing(AppSpacing.spacing4),
          Text(
            '${InvitaionsStrings.createdBy}${invitation.creatorName}',
            style: AppTextStyles.labelSmall.copyWith(
              color: context.appColors.textSecondary,
            ),
          ),
          VerticalSpacing(AppSpacing.spacing16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${invitation.membersCount} Members',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: context.appColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  VerticalSpacing(AppSpacing.spacing6),
                  AvatarStack(avatarUrls: invitation.memberAvatars),
                ],
              ),
              invitation.status.toLowerCase() == 'pending'
                  ? GestureDetector(
                      onTap: onReview,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.spacing20,
                          vertical: AppSpacing.spacing10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppSpacing.radius10,
                          ),
                          gradient: AppColorScheme.gradient,
                        ),
                        child: Text(
                          InvitaionsStrings.requestReview,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        context.goNamed(BridgeXRouteNames.projects);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Open Project',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: context.appColors.success,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const HorizontalSpacing(6),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                            color: context.appColors.success,
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
