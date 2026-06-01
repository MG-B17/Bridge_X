import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/inputs/bridge_x_text_form_field.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';

import 'username_field.dart';
import 'profession_dropdown.dart';
import 'bio_field.dart';

class EditProfileFormFields extends StatelessWidget {
  const EditProfileFormFields({
    required this.fullNameController,
    required this.usernameController,
    required this.emailController,
    required this.bioController,
    required this.professionController,
    required this.selectedProfession,
    required this.professions,
    required this.onProfessionChanged,
    super.key,
  });

  final TextEditingController fullNameController;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController bioController;
  final TextEditingController professionController;
  final String selectedProfession;
  final List<String> professions;
  final Function(String) onProfessionChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        BridgeXTextFormField(
          label: AppStrings.fullName,
          hint: AppStrings.fullNameHint,
          controller: fullNameController,
        ),

        VerticalSpacing(AppSpacing.lg),

        
        UsernameField(controller: usernameController),

        VerticalSpacing(AppSpacing.lg),

        
        ProfessionDropdown(
          key: ValueKey(selectedProfession),
          selectedValue: selectedProfession,
          professions: professions,
          onChanged: onProfessionChanged,
        ),

        VerticalSpacing(AppSpacing.lg),

        
        BridgeXTextFormField(
          label: AppStrings.emailAddress,
          hint: AppStrings.emailHint,
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
        ),

        VerticalSpacing(AppSpacing.lg),


        BioField(controller: bioController),
      ],
    );
  }
}
