import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_names.dart';
import 'package:bridge_x/core/navigation/screens_args/create_task_args.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_button.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/dashboard/team_settings_entity.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/widgets/team_setting_widget/section_header.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/widgets/team_setting_widget/team_danger_zone.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/widgets/team_setting_widget/team_info_card.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/widgets/team_setting_widget/team_members_section.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/widgets/team_setting_widget/team_project_control.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/widgets/team_setting_widget/team_settings_header.dart';
import 'package:bridge_x/features/team_managment/utils/project_strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TeamSettingsContent extends StatelessWidget {
  final TeamSettingsEntity teamSettings;

  const TeamSettingsContent({
    super.key,
    required this.teamSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TeamSettingsHeader(),
        VerticalSpacing(AppSpacing.spacing24),
        TeamInfoCard(
          teamName: teamSettings.teamName,
          projectDescription: teamSettings.projectDescription,
          githubLink: teamSettings.githubLink.isNotEmpty
              ? teamSettings.githubLink
              : null,
        ),
        VerticalSpacing(AppSpacing.spacing24),
        TeamMembersSection(
          members: teamSettings.members,
          projectId: teamSettings.projectId,
        ),
        VerticalSpacing(AppSpacing.spacing24),
        SectionHeader(title: ProjectStrings.assignTasks.toUpperCase()),
        VerticalSpacing(AppSpacing.spacing8),
        if (teamSettings.teamId != null && teamSettings.projectId != null)
          BridgeXButton(
            text: ProjectStrings.createAssignTask,
            prefixicon: Icons.playlist_add_check,
            onTap: () {
              context.pushNamed(
                BridgeXRouteNames.createTask,
                extra: CreateTaskArgs(
                  teamId: teamSettings.teamId!,
                  projectId: teamSettings.projectId!,
                ),
              );
            },
          ),
        VerticalSpacing(AppSpacing.spacing24),
        TeamProjectControl(projectId: teamSettings.projectId),
        VerticalSpacing(AppSpacing.spacing24),
        TeamDangerZone(projectId: teamSettings.projectId),
        VerticalSpacing(AppSpacing.spacing20),
      ],
    );
  }
}
