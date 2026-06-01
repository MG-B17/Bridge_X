import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/team_setting_widget/section_header.dart';
import 'package:flutter/material.dart';

class TeamDangerZone extends StatelessWidget {
  const TeamDangerZone({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: AppStrings.dangerZone.toUpperCase(),
          color: context.colors.error,
        ),
        VerticalSpacing(AppSpacing.spacing8),
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(AppStrings.removeTeamSubmitted),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppSpacing.spacing16),
            decoration: BoxDecoration(
              color: context.colors.error.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(AppSpacing.radius16),
              border: Border.all(
                color: context.colors.error.withValues(alpha: 0.3),
                width: 1.0,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.removeTeam,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.colors.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.delete_forever_outlined,
                  color: context.colors.error,
                  size: AppSpacing.fontSize22,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
