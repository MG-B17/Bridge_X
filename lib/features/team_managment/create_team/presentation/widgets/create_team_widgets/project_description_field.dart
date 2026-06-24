import 'package:bridge_x/core/widget/inputs/bridge_x_text_form_field.dart';
import 'package:bridge_x/features/team_managment/utils/create_team_strings.dart';
import 'package:flutter/material.dart';

class ProjectDescriptionField extends StatelessWidget {
  const ProjectDescriptionField({
    super.key,
    required this.controller,
    this.validator,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return BridgeXTextFormField(
      label: CreateTeamStrings.projectDescription,
      hint: CreateTeamStrings.describeProjectHint,
      controller: controller,
      maxLines: 5,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      validator: validator,
    );
  }
}
