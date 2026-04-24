import 'package:flutter/material.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/bridge_app_button.dart';
import '../../../../core/widgets/v_space.dart';
import '../widgets/edit_profile_avatar.dart';
import '../widgets/edit_profile_form.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _bioController;

  String? _selectedRole;

  final List<String> _roles = [
    'Product Designer',
    'Frontend Developer',
    'Backend Developer',
    'UI/UX Designer',
    'Flutter Developer',
    'Data Scientist',
    'DevOps Engineer',
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
    _selectedRole = _roles.first;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colors.scaffoldBg,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: context.colors.textPrimary,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          AppStrings.editProfile,
          style: context.titleLarge.copyWith(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
          child: Column(
            children: [
              VSpace(context.spacing.lg),
              EditProfileAvatar(onTap: _onAvatarTap),
              VSpace(context.spacing.xxl),
              EditProfileForm(
                fullNameController: _fullNameController,
                usernameController: _usernameController,
                emailController: _emailController,
                bioController: _bioController,
                selectedRole: _selectedRole,
                roles: _roles,
                onRoleChanged: (value) {
                  setState(() => _selectedRole = value);
                },
              ),
              VSpace(context.spacing.xxl),
              AppButton(
                label: AppStrings.saveChanges,
                onPressed: _onSave,
              ),
              VSpace(context.spacing.md),
              AppButton(
                label: AppStrings.cancel,
                onPressed: () => context.pop(),
                isSecondary: true,
              ),
              VSpace(context.spacing.xxl),
            ],
          ),
        ),
      ),
    );
  }

  void _onAvatarTap() {
    // TODO: Implement avatar picker
  }

  void _onSave() {
    // TODO: Implement save logic
    context.pop();
  }
}
