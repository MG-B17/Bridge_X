import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/widget/bridge_x_screen_header.dart';
import '../widget/edit_profile_screen_widget/edit_profile_avatar.dart';
import '../widget/edit_profile_screen_widget/edit_profile_form_fields.dart';
import '../widget/edit_profile_screen_widget/edit_profile_actions.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _fullNameController;
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _bioController;
  late TextEditingController _professionController;

  String _selectedProfession = 'Product Designer';

  final List<String> _professions = [
    'Product Designer',
    'Frontend Developer',
    'Backend Developer',
    'Full Stack Developer',
    'UI/UX Designer',
    'Data Scientist',
  ];

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: 'Ahmed');
    _usernameController = TextEditingController(text: 'ahmed_amer');
    _emailController = TextEditingController(text: 'ahmed.h@company.com');
    _bioController = TextEditingController(
      text:
          'Product Designer based in New York. Passionate about creating accessible and high-fidelity user experiences for modern SaaS products.',
    );
    _professionController = TextEditingController(text: 'Product Designer');
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    _professionController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BridgeXScreenHeader(
                title: AppStrings.editProfile,
                titleStyle: AppTextStyles.headlineMedium.copyWith(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
                spacing: AppSpacing.lg,
              ),
              VerticalSpacing(AppSpacing.xl),
              const Center(child: EditProfileAvatar()),
              VerticalSpacing(AppSpacing.xl),
              EditProfileFormFields(
                fullNameController: _fullNameController,
                usernameController: _usernameController,
                emailController: _emailController,
                bioController: _bioController,
                professionController: _professionController,
                selectedProfession: _selectedProfession,
                professions: _professions,
                onProfessionChanged: (value) {
                  setState(() {
                    _selectedProfession = value;
                    _professionController.text = value;
                  });
                },
              ),
              VerticalSpacing(AppSpacing.xxl),
              EditProfileActions(onSave: (){}),
              VerticalSpacing(AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}
