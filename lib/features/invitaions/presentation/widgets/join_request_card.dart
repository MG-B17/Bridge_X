import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/theme/app_color_schema.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/extensions.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/features/invitaions/domain/entities/join_request_entity.dart';
import 'package:bridge_x/features/invitaions/presentation/utils/invitaions_strings.dart';
import 'package:bridge_x/features/invitaions/presentation/widgets/expertise_wrap.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JoinRequestCard extends StatelessWidget {
  final JoinRequestEntity joinRequest;
  final VoidCallback onReview;

  const JoinRequestCard({
    super.key,
    required this.joinRequest,
    required this.onReview,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSpacing.spacing16),
      padding: EdgeInsets.all(AppSpacing.spacing16),
      decoration: BoxDecoration(
        color: context.appColors.surface,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.appColors.divider,
                    width: 1.0,
                  ),
                ),
                child: CircleAvatar(
                  radius: 24.r,
                  backgroundImage: CachedNetworkImageProvider(joinRequest.userAvatar),
                  backgroundColor: context.appColors.primaryLight,
                ),
              ),
              const HorizontalSpacing(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            joinRequest.userName,
                            style: AppTextStyles.titleLarge.copyWith(
                              color: context.appColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (joinRequest.isNew)
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
                              InvitaionsStrings.newBadge,
                              style: AppTextStyles.labelSmall.copyWith(
                                color: context.appColors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Text(
                      joinRequest.userHandle,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: context.appColors.textSecondary,
                      ),
                    ),
                    VerticalSpacing(AppSpacing.spacing6),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSpacing.spacing8,
                            vertical: AppSpacing.spacing2,
                          ),
                          decoration: BoxDecoration(
                            color: context.appColors.primaryLight.withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(AppSpacing.radius5),
                          ),
                          child: Text(
                            joinRequest.userRole,
                            style: AppTextStyles.labelSmall.copyWith(
                              color: context.appColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const HorizontalSpacing(8),
                        Icon(
                          Icons.star_rounded,
                          color: context.appColors.gold,
                          size: 16.r,
                        ),
                        const HorizontalSpacing(2),
                        Text(
                          joinRequest.userRating.toString(),
                          style: AppTextStyles.labelSmall.copyWith(
                            color: context.appColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          VerticalSpacing(AppSpacing.spacing12),
          ExpertiseWrap(
            tags: joinRequest.expertiseTags.take(3).toList(),
          ),
          VerticalSpacing(AppSpacing.spacing14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${InvitaionsStrings.applied} ${joinRequest.appliedTimeAgo}',
                style: AppTextStyles.labelSmall.copyWith(
                  color: context.appColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                onTap: onReview,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.spacing20,
                    vertical: AppSpacing.spacing10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSpacing.radius10),
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
