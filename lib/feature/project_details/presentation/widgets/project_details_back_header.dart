import 'package:bridge_x/core/widget/buttons/bridge_x_back_button.dart';
import 'package:flutter/material.dart';

class ProjectDetailsBackHeader extends StatelessWidget {
  const ProjectDetailsBackHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft,
      child: BridgeXBackButton(),
    );
  }
}
