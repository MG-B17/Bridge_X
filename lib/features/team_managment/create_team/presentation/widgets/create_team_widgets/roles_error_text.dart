import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/features/team_managment/utils/create_team_strings.dart';
import 'package:flutter/material.dart';

class RolesErrorText extends StatelessWidget {
  const RolesErrorText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppSpacing.spacing6),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.spacing8,
        ),
        child: Text(
          CreateTeamStrings.pleaseAddRole,
          style: TextStyle(
            color: context.colors.error,
            fontSize: AppSpacing.fontSize12,
          ),
        ),
      ),
    );
  }
}
