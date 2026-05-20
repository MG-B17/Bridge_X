import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/widget/bridge_x_text_form_field.dart';
import 'package:flutter/material.dart';

class ProjectDescriptionField extends StatelessWidget {
  const ProjectDescriptionField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BridgeXTextFormField(
      label: AppStrings.projectDescription,
      hint: AppStrings.describeProjectHint,
      controller: controller,
      maxLines: 5,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
    );
  }
}
