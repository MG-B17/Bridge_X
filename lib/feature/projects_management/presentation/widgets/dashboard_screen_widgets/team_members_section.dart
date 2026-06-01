import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/dashboard/project_dashboard_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/dashboard/project_member_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TeamMembersSection extends StatelessWidget {
  final ProjectDashboardEntity project;

  const TeamMembersSection({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.teamMembers,
              style: AppTextStyles.titleLarge.copyWith(
                color: context.colors.textPrimary,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                AppStrings.manageAll,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: context.colors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        VerticalSpacing(AppSpacing.spacing12),
        Row(
          children: [
            if (project.members.isNotEmpty)
              MemberCard(member: project.members[0]),
            if (project.members.length > 1) ...[
              HorizontalSpacing(AppSpacing.spacing12),
              Expanded(child: MemberCard(member: project.members[1])),
            ],
          ],
        ),
      ],
    );
  }
}

class MemberCard extends StatelessWidget {
  final ProjectMemberEntity member;

  const MemberCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSpacing.width180,
      height: AppSpacing.width180,
      padding: EdgeInsets.all(AppSpacing.spacing12),
      decoration: BoxDecoration(
        color: context.colors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.spacing8,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Icon(
              Icons.more_vert,
              color: context.colors.textHint,
              size: AppSpacing.fontSize18,
            ),
          ),
          CircleAvatar(
            radius: AppSpacing.spacing24,
            backgroundImage: member.avatarUrl != null
                ? CachedNetworkImageProvider(member.avatarUrl!)
                : null,
            child: member.avatarUrl == null
                ? const Icon(Icons.person, size: 28)
                : null,
          ),
          Text(
            member.name,
            style: AppTextStyles.titleMedium.copyWith(
              color: context.colors.textPrimary,
            ),
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            member.track,
            style: AppTextStyles.labelSmall.copyWith(
              color: context.colors.textSecondary,
            ),
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.check_circle_outline,
                color: context.colors.success,
                size: AppSpacing.fontSize14,
              ),
              HorizontalSpacing(AppSpacing.spacing4),
              Text(
                member.tasksSummary,
                style: AppTextStyles.labelSmall.copyWith(
                  color: context.colors.textSecondary,
                ),
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
