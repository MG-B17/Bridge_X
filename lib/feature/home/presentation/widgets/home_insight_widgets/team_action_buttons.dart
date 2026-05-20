import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/bridge_x_button.dart';
import 'package:bridge_x/core/widget/bridge_x_outline_button.dart';
import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TeamActionButtons extends StatelessWidget {
  const TeamActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BridgeXButton(
            text: AppStrings.joinTeam,
            prefixicon: Icons.group_add_outlined,
            onTap: () {
              context.pushNamed(BridegeXRouteNames.selectCategory);
            },
          ),
        ),
        HorizontalSpacing(AppSpacing.spacing8),
        Expanded(
          child: BridgeXOutlineButton(
            text: AppStrings.createTeam,
            prefixicon: Icons.add_circle_outline,
            onTap: () {
              context.pushNamed(BridegeXRouteNames.createTeam);
            },
          ),
        ),
      ],
    );
  }
}
