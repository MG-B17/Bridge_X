import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_back_button.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/team_managment/utils/project_strings.dart';
import 'package:flutter/material.dart';

class TeamSettingsHeader extends StatelessWidget {
  const TeamSettingsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: BridgeXBackButton(
            backgroundColor: context.colors.primaryLight,
            iconColor: context.colors.primary,
          ),
        ),
        VerticalSpacing(AppSpacing.spacing16),
        Text(
          ProjectStrings.teamSettings,
          style: context.textTheme.displayLarge?.copyWith(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: AppSpacing.fontSize24,
          ),
        ),
        VerticalSpacing(AppSpacing.spacing4),
        Text(
          ProjectStrings.mentorAccess,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colors.textSecondary,
          ),
        ),
      ],
    );
  }
}
