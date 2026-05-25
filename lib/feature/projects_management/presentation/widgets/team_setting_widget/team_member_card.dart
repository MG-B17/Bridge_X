import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/dashboard/team_member_entity.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/team_setting_widget/avatar_utils.dart';
import 'package:flutter/material.dart';

class TeamMemberCard extends StatelessWidget {
  final TeamMemberEntity member;

  const TeamMemberCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSpacing.spacing12),
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.spacing16,
        vertical: AppSpacing.spacing12,
      ),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radius16),
        border: Border.all(
          color: context.colors.primaryLight,
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: AppSpacing.radius20,
            backgroundColor: AvatarUtils.background(member.programmerId),
            child: Text(
              AvatarUtils.initials(member.name),
              style: context.textTheme.titleMedium?.copyWith(
                color: AvatarUtils.text(member.programmerId),
                fontWeight: FontWeight.bold,
                fontSize: AppSpacing.fontSize14,
              ),
            ),
          ),
          HorizontalSpacing(AppSpacing.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.colors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  member.track,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.colors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: context.colors.textSecondary,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${AppStrings.memberSettingsFor} ${member.name}'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
