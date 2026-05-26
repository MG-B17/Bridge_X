import 'dart:io';
import 'package:bridge_x/core/animation/bottom_nav_bar_animation/widget/scroller_listener.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_snackbar.dart';
import 'package:bridge_x/core/widget/layout/bridge_x_screen_header.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_skeletonizer.dart';
import 'package:bridge_x/feature/profile/data/models/update_profile_request_model.dart';
import 'package:bridge_x/feature/profile/domain/entities/edit_profile_entity.dart';
import 'package:bridge_x/feature/profile/presentation/controller/edit_profile_cubit.dart';
import 'package:bridge_x/feature/profile/presentation/controller/edit_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
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
  final ScrollController _scrollController = ScrollController();

  String _selectedProfession = '';
  String? _pickedImagePath;

  // Original values for change detection
  EditProfileEntity? _originalProfile;

  final List<String> _professions = [
    'Product Designer',
    'Frontend Developer',
    'Backend Developer',
    'Full Stack Developer',
    'Flutter Developer',
    'UI/UX Designer',
    'Data Scientist',
  ];

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _bioController = TextEditingController();
    _professionController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    _professionController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _populateFields(EditProfileEntity profile) {
    _originalProfile = profile;
    _fullNameController.text = profile.fullName;
    _usernameController.text = profile.userName;
    _emailController.text = profile.email;
    _bioController.text = profile.bio;

    // Match track case-insensitively, or add it to the list
    final matched = _professions.firstWhere(
      (p) => p.toLowerCase() == profile.track.toLowerCase(),
      orElse: () => '',
    );
    if (matched.isNotEmpty) {
      _selectedProfession = matched;
    } else if (profile.track.isNotEmpty) {
      _professions.add(profile.track);
      _selectedProfession = profile.track;
    }
    _professionController.text = _selectedProfession;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked != null && mounted) {
      setState(() => _pickedImagePath = picked.path);
    }
  }

  void _handleSave(BuildContext context) {
    final original = _originalProfile;
    if (original == null) return;

    final request = UpdateProfileRequestModel(
      fullName: _fullNameController.text.trim() != original.fullName
          ? _fullNameController.text.trim()
          : null,
      userName: _usernameController.text.trim() != original.userName
          ? _usernameController.text.trim()
          : null,
      bio: _bioController.text.trim() != original.bio
          ? _bioController.text.trim()
          : null,
      track: _selectedProfession != original.track ? _selectedProfession : null,
      avatarFile: _pickedImagePath != null ? File(_pickedImagePath!) : null,
    );

    if (!request.hasChanges) return;

    context.read<EditProfileCubit>().updateProfile(request);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditProfileCubit>(
      create: (_) => sl<EditProfileCubit>()..fetchProfile(),
      child: BlocConsumer<EditProfileCubit, EditProfileState>(
        listener: (context, state) {
          if (state is EditProfileLoaded && _originalProfile == null) {
            _populateFields(state.profile);
          }
          if (state is EditProfileUpdated) {
            BridgeXSnackBar.showSuccess(context: context, message: 'Profile updated successfully');
            if (context.mounted) context.pop();
          }
          if (state is EditProfileError) {
            BridgeXSnackBar.showError(context: context, message: state.message);
          }
        },
        builder: (context, state) {
          final isLoading = state is EditProfileInitial || state is EditProfileLoading;
          final isUpdating = state is EditProfileUpdating;

          return ScrollNavListener(
            controller: _scrollController,
            child: Scaffold(
              body: SafeArea(
                child: BridgeXSkeletonizer(
                  enableloading: isLoading,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                      left: AppSpacing.lg,
                      right: AppSpacing.lg,
                      top: AppSpacing.md,
                      bottom: AppSpacing.md + AppSpacing.spacing20,
                    ),
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
                        Center(
                          child: EditProfileAvatar(
                            avatarUrl: _originalProfile?.avatarUrl,
                            pickedImagePath: _pickedImagePath,
                            onTap: _pickImage,
                          ),
                        ),
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
                        EditProfileActions(
                          onSave: () => _handleSave(context),
                          isLoading: isUpdating,
                        ),
                        VerticalSpacing(AppSpacing.xl),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
