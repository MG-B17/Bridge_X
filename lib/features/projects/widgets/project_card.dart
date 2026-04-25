import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';
import '../../../../core/widgets/h_space.dart';

class ProjectCard extends StatelessWidget {
  final String status;
  final String title;
  final String role;
  final double? rating;
  final String? finishedDate;
  final double? progress;
  final String? progressPhase;
  final List<String> avatars;
  final int? extraAvatars;
  final bool isYourTeam;
  final VoidCallback? onActionTap;
  final String? actionText;
  final IconData? icon;
  final String? categoryLabel;

  const ProjectCard({
    super.key,
    required this.status,
    required this.title,
    required this.role,
    this.rating,
    this.finishedDate,
    this.progress,
    this.progressPhase,
    this.avatars = const [],
    this.extraAvatars,
    this.isYourTeam = false,
    this.onActionTap,
    this.actionText,
    this.icon,
    this.categoryLabel,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCompleted = status.toUpperCase() == 'COMPLETED';

    return Container(
      margin: EdgeInsets.only(bottom: context.spacing.lg),
      padding: EdgeInsets.all(context.spacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
        border: Border.all(color: context.colors.textHint.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onActionTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (icon != null)
                  Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      color: context.colors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(icon, color: context.colors.primary, size: 24.r),
                  )
                else if (categoryLabel != null)
                  Text(
                    categoryLabel!.toUpperCase(),
                    style: context.labelSmall.copyWith(
                      color: Colors.brown.shade700,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0,
                    ),
                  )
                else
                  _buildStatusBadge(context, isCompleted),
                
                if (icon != null || categoryLabel != null)
                  _buildStatusBadge(context, isCompleted)
                else if (isYourTeam)
                  _buildYourTeamBadge(context),
              ],
            ),
            VSpace(context.spacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: context.titleLarge.copyWith(
                      fontWeight: FontWeight.w900,
                      color: context.colors.textPrimary,
                    ),
                  ),
                ),
                if (rating != null && !isCompleted)
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 18.r),
                      SizedBox(width: 4.w),
                      Text(
                        rating.toString(),
                        style: context.bodyMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colors.textPrimary,
                        ),
                      ),
                    ],
                  )
                else if (icon != null && isYourTeam)
                  _buildYourTeamBadge(context),
              ],
            ),
            VSpace(context.spacing.xs),
            Text(
              role,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.bodyMedium.copyWith(
                color: context.colors.textSecondary,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
            
            if (finishedDate != null && !isCompleted) ...[
              VSpace(context.spacing.sm),
              Text(
                'Finished: $finishedDate',
                style: context.labelSmall.copyWith(
                  color: context.colors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
  
            if (progress != null) ...[
              VSpace(context.spacing.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    progressPhase ?? 'Development Phase',
                    style: context.labelSmall.copyWith(
                      color: context.colors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${(progress! * 100).toInt()}%',
                    style: context.labelSmall.copyWith(
                      color: context.colors.textPrimary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              VSpace(context.spacing.xs),
              ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 6.h,
                  backgroundColor: context.colors.textHint.withValues(alpha: 0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(context.colors.primary),
                ),
              ),
            ],
  
            VSpace(context.spacing.lg),
            if (isCompleted) ...[
              const Divider(height: 1),
              VSpace(context.spacing.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        actionText ?? 'View Report',
                        style: context.bodyMedium.copyWith(
                          color: context.colors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      HSpace(4.w),
                      Icon(Icons.arrow_forward, color: context.colors.primary, size: 16.r),
                    ],
                  ),
                  if (finishedDate != null)
                    Text(
                      finishedDate!,
                      style: context.labelSmall.copyWith(
                        color: context.colors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
            ] else
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildAvatars(context),
                  Row(
                    children: [
                      Text(
                        actionText ?? 'Details',
                        style: context.bodyMedium.copyWith(
                          color: context.colors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.chevron_right, color: context.colors.primary, size: 18.r),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, bool isCompleted) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isCompleted ? Colors.green.withValues(alpha: 0.1) : context.colors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(context.spacing.radiusPill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isCompleted) ...[
            Icon(Icons.check_circle, color: Colors.green.shade700, size: 14.r),
            HSpace(4.w),
          ],
          Text(
            status.toUpperCase(),
            style: context.labelSmall.copyWith(
              color: isCompleted ? Colors.green.shade700 : context.colors.primary,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYourTeamBadge(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: context.colors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(context.spacing.radiusPill),
      ),
      child: Text(
        'Your Team',
        style: context.labelSmall.copyWith(
          color: context.colors.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAvatars(BuildContext context) {
    if (avatars.isEmpty && extraAvatars == null) return const SizedBox.shrink();

    return SizedBox(
      height: 32.r,
      width: (avatars.length * 20.r) + (extraAvatars != null ? 36.r : 16.r),
      child: Stack(
        children: [
          for (int i = 0; i < avatars.length; i++)
            Positioned(
              left: i * 20.r,
              child: CircleAvatar(
                radius: 16.r,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 14.r,
                  backgroundImage: NetworkImage(avatars[i]),
                ),
              ),
            ),
          if (extraAvatars != null)
            Positioned(
              left: avatars.length * 20.r,
              child: CircleAvatar(
                radius: 16.r,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 14.r,
                  backgroundColor: context.colors.primary.withValues(alpha: 0.1),
                  child: Text(
                    '+$extraAvatars',
                    style: context.labelSmall.copyWith(
                      color: context.colors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
