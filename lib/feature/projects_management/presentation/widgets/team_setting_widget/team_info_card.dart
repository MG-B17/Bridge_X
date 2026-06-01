import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/team_setting_widget/info_field.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/team_setting_widget/section_header.dart';
import 'package:flutter/material.dart';

class TeamInfoCard extends StatelessWidget {
  final String teamName;
  final String projectDescription;
  final String? githubLink;

  const TeamInfoCard({
    super.key,
    required this.teamName,
    required this.projectDescription,
    this.githubLink,
  });

  @override
  Widget build(BuildContext context) {
    final hasGithub = githubLink != null && githubLink!.isNotEmpty;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.spacing16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radius16),
        border: Border.all(
          color: context.colors.primaryLight,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: AppStrings.teamInfo.toUpperCase()),
          VerticalSpacing(AppSpacing.spacing16),
          InfoField(
            label: AppStrings.teamName.toUpperCase(),
            value: teamName,
          ),
          VerticalSpacing(AppSpacing.spacing16),
          InfoField(
            label: AppStrings.projectDescription.toUpperCase(),
            value: projectDescription,
          ),
          if (hasGithub) ...[
            VerticalSpacing(AppSpacing.spacing16),
            InfoField(
              label: AppStrings.githubUrl.toUpperCase(),
              value: githubLink!,
            ),
          ],
        ],
      ),
    );
  }
}
