import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/details/team_member_entity.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/details_screen_widgets/team_member_avatar.dart';
import 'package:flutter/material.dart';

class TeamMembersSection extends StatelessWidget {
  const TeamMembersSection({
    super.key,
    required this.teamMembers,
    required this.teamMembersCount,
  });

  final List<TeamMemberEntity> teamMembers;
  final int teamMembersCount;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                AppStrings.teamMembers,
                style: AppTextStyles.titleLarge.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              '$teamMembersCount ${AppStrings.active}',
              style: AppTextStyles.bodyMedium.copyWith(
                color: colors.textSecondary,
              ),
            ),
          ],
        ),
        VerticalSpacing(AppSpacing.md),
        if (teamMembers.isNotEmpty)
          SizedBox(
            height: AppSpacing.spacing72,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: teamMembers.length,
              separatorBuilder: (context, index) => HorizontalSpacing(AppSpacing.md),
              itemBuilder: (context, index) => TeamMemberAvatar(
                member: teamMembers[index],
              ),
            ),
          ),
      ],
    );
  }
}
