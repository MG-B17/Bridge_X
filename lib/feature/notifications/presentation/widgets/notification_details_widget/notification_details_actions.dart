import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_button.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_outline_button.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';

class NotificationDetailsActions extends StatelessWidget {
  const NotificationDetailsActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BridgeXButton(
          text: AppStrings.viewTeam,
          onTap: () {},
        ),
        VerticalSpacing(AppSpacing.spacing16),
        BridgeXOutlineButton(
          text: AppStrings.backToHome,
          onTap: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ],
    );
  }
}
