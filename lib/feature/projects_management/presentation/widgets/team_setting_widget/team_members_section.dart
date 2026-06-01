import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/dashboard/team_member_entity.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/team_setting_widget/section_header.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/team_setting_widget/team_member_card.dart';
import 'package:flutter/material.dart';

class TeamMembersSection extends StatelessWidget {
  final List<TeamMemberEntity> members;

  const TeamMembersSection({super.key, required this.members});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SectionHeader(title: AppStrings.membersManagement.toUpperCase()),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.spacing8,
                vertical: AppSpacing.spacing4,
              ),
              decoration: BoxDecoration(
                color: context.colors.primaryLight,
                borderRadius: BorderRadius.circular(AppSpacing.radius12),
              ),
              child: Text(
                '${members.length} ${AppStrings.teamMembers.toUpperCase()}',
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: AppSpacing.fontSize10,
                ),
              ),
            ),
          ],
        ),
        VerticalSpacing(AppSpacing.spacing8),
        if (members.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppSpacing.spacing24),
            decoration: BoxDecoration(
              color: context.colors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radius16),
              border: Border.all(
                color: context.colors.primaryLight,
                width: 1.0,
              ),
            ),
            child: Center(
              child: Text(
                AppStrings.noMembersInTeam,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.textSecondary,
                ),
              ),
            ),
          )
        else
          ...members.map((member) => TeamMemberCard(member: member)),
      ],
    );
  }
}
