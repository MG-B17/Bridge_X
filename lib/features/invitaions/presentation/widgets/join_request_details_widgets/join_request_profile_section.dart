import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/extensions.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/invitaions/domain/entities/join_request_entity.dart';
import 'package:bridge_x/features/invitaions/presentation/utils/invitaions_strings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class JoinRequestProfileSection extends StatelessWidget {
  final JoinRequestEntity joinRequest;

  const JoinRequestProfileSection({
    super.key,
    required this.joinRequest,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: context.appColors.primary.withValues(alpha: 0.2),
                width: AppSpacing.width2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: AppSpacing.spacing15,
                  offset: Offset(0, AppSpacing.spacing8),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: AppSpacing.spacing48 + AppSpacing.spacing4,
              backgroundImage: CachedNetworkImageProvider(joinRequest.userAvatar),
              backgroundColor: context.appColors.primaryLight,
            ),
          ),
          VerticalSpacing(AppSpacing.spacing16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                joinRequest.userName,
                style: AppTextStyles.displayLarge.copyWith(
                  color: context.appColors.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              if (joinRequest.isNew) ...[
                HorizontalSpacing(AppSpacing.spacing8),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.spacing8,
                    vertical: AppSpacing.spacing2,
                  ),
                  decoration: BoxDecoration(
                    color: context.appColors.amber.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppSpacing.radius5),
                  ),
                  child: Text(
                    InvitaionsStrings.newTag,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: context.appColors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: AppSpacing.fontSize10,
                    ),
                  ),
                ),
              ],
            ],
          ),
          Text(
            joinRequest.userHandle,
            style: AppTextStyles.bodyMedium.copyWith(
              color: context.appColors.textSecondary,
            ),
          ),
          VerticalSpacing(AppSpacing.spacing8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                  joinRequest.userRole,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: context.appColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              HorizontalSpacing(AppSpacing.spacing10),
              Icon(
                Icons.star_rounded,
                color: context.appColors.gold,
                size: AppSpacing.fontSize18,
              ),
              HorizontalSpacing(AppSpacing.spacing2),
              Text(
                joinRequest.userRating.toString(),
                style: AppTextStyles.bodyMedium.copyWith(
                  color: context.appColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
