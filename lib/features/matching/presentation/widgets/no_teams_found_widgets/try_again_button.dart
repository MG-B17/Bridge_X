import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_button.dart';
import 'package:flutter/material.dart';

/// Full-width gradient "Try Again" button for re-triggering the matching flow.
class TryAgainButton extends StatelessWidget {
  const TryAgainButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return BridgeXButton(
      text: AppStrings.tryAgain,
      onTap: onTap,
    );
  }
}
