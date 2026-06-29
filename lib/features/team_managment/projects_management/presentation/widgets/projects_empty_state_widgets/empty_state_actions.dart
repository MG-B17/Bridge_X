import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_button.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_outline_button.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/team_managment/utils/project_strings.dart';
import 'package:flutter/material.dart';


class EmptyStateActions extends StatelessWidget {
  const EmptyStateActions({
    super.key,
    this.onExploreTeams,
    this.onCreateTeam,
  });

  final VoidCallback? onExploreTeams;
  final VoidCallback? onCreateTeam;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        BridgeXButton(
          text: ProjectStrings.exploreTeams,
          suffixicon: Icons.arrow_forward,
          onTap: onExploreTeams,
        ),
        VerticalSpacing(AppSpacing.sm),

        BridgeXOutlineButton(
          text: ProjectStrings.createTeam,
          prefixicon: Icons.groups_outlined,
          onTap: onCreateTeam,
        ),
      ],
    );
  }
}
