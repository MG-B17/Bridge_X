import 'package:bridge_x/core/animation/bottom_nav_bar_animation/widget/scroller_listener.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_button.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_error_widget.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_snackbar.dart';
import 'package:bridge_x/core/widget/layout/bridge_x_background_gears.dart';
import 'package:bridge_x/core/widget/layout/bridge_x_screen_header.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_skeletonizer.dart';
import 'package:bridge_x/features/skills_and_experience/data/model/update_skills_experience_request_model.dart';
import 'package:bridge_x/features/skills_and_experience/domain/entities/skills_experience_entity.dart';
import 'package:bridge_x/features/skills_and_experience/presentation/controller/skills_experience_cubit.dart';
import 'package:bridge_x/features/skills_and_experience/presentation/controller/skills_experience_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../widget/skills_and_experience_widget/experience_description_section.dart';
import '../widget/skills_and_experience_widget/experience_level_section.dart';
import '../widget/skills_and_experience_widget/projects_section.dart';
import '../widget/skills_and_experience_widget/skills_section.dart';

class SkillsAndExperienceScreen extends StatefulWidget {
  const SkillsAndExperienceScreen({super.key});

  @override
  State<SkillsAndExperienceScreen> createState() =>
      _SkillsAndExperienceScreenState();
}

class _SkillsAndExperienceScreenState extends State<SkillsAndExperienceScreen> {
  late final TextEditingController _experienceController;
  final ScrollController _scrollController = ScrollController();
  SkillsExperienceEntity? _originalSkillsExperience;
  String _experienceLevel = '';
  List<String> _skills = [];

  @override
  void initState() {
    super.initState();
    _experienceController = TextEditingController();
  }

  @override
  void dispose() {
    _experienceController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _populateFields(SkillsExperienceEntity skillsExperience) {
    _originalSkillsExperience = skillsExperience;
    _experienceLevel = skillsExperience.experienceLevel;
    _skills = List<String>.from(skillsExperience.skills);
    _experienceController.text = skillsExperience.experience ?? '';
  }

  void _handleSave(BuildContext context) {
    final original = _originalSkillsExperience;
    if (original == null) return;

    final experience = _experienceController.text.trim();
    final hasSkillsChanged = _skills.length != original.skills.length ||
        !_skills.every(original.skills.contains);
    final hasExperienceChanged = experience != (original.experience ?? '');

    if (!hasSkillsChanged && !hasExperienceChanged) {
      BridgeXSnackBar.showWarning(
        context: context,
        message: 'No changes to save',
      );
      return;
    }

    final request = UpdateSkillsExperienceRequestModel(
      skills: _skills,
      experience: experience,
    );

    context.read<SkillsExperienceCubit>().updateSkillsExperience(request);
  }

  Future<void> _showAddSkillDialog() async {
    String skillValue = '';

    final skill = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: context.colors.surface,
          title: Text(
            AppStrings.addSkill,
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            autofocus: true,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: AppStrings.skills,
              hintStyle: context.textTheme.bodyMedium?.copyWith(
                color: context.colors.textHint,
              ),
            ),
            onChanged: (value) => skillValue = value,
            onSubmitted: (value) => Navigator.of(dialogContext).pop(value),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(AppStrings.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(skillValue),
              child: Text(AppStrings.confirm),
            ),
          ],
        );
      },
    );

    final trimmedSkill = skill?.trim();
    if (trimmedSkill == null || trimmedSkill.isEmpty) return;
    if (_skills.any(
      (existingSkill) =>
          existingSkill.toLowerCase() == trimmedSkill.toLowerCase(),
    )) {
      return;
    }
    if (!mounted) return;

    setState(() {
      _skills = [..._skills, trimmedSkill];
    });
  }

  Widget _buildBody(
    BuildContext context,
    bool isLoading,
    bool isUpdating,
    SkillsExperienceState state,
  ) {
    final isLoadError =
        state is SkillsExperienceError && _originalSkillsExperience == null;

    if (isLoadError) {
      return BridgeXErrorWidget(
        errorTittle: 'Failed to Load Skills & Experience',
        errorMessage: state.message,
        refreshButtonTap: () =>
            context.read<SkillsExperienceCubit>().fetchSkillsExperience(),
      );
    }

    return BridgeXSkeletonizer(
      enableloading: isLoading,
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          left: AppSpacing.spacing16,
          right: AppSpacing.spacing16,
          top: AppSpacing.spacing16,
          bottom: AppSpacing.spacing16 + AppSpacing.spacing20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -- Screen Header --
            const BridgeXScreenHeader(
              title: AppStrings.skillsAndExperience,
            ),
            VerticalSpacing(AppSpacing.spacing24),

            // -- Experience Level Card --
            ExperienceLevelSection(experienceLevel: _experienceLevel),
            VerticalSpacing(AppSpacing.spacing24),

            // -- Skills Card --
            SkillsSection(
              skills: _skills,
              onAddSkill: _showAddSkillDialog,
              onRemoveSkill: (skill) {
                setState(() {
                  _skills = _skills.where((item) => item != skill).toList();
                });
              },
            ),
            VerticalSpacing(AppSpacing.spacing24),

            // -- Experience Description Card --
            ExperienceDescriptionSection(controller: _experienceController),
            VerticalSpacing(AppSpacing.spacing24),

            const ProjectsSection(),
            VerticalSpacing(AppSpacing.spacing32),

            // -- Save Changes --
            BridgeXButton(
              text: AppStrings.saveChanges,
              isLoading: isUpdating,
              onTap: () => _handleSave(context),
            ),
            VerticalSpacing(AppSpacing.spacing16),

            // -- Cancel --
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  AppStrings.cancel,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.textSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            VerticalSpacing(AppSpacing.spacing24),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SkillsExperienceCubit>(
      create: (_) => sl<SkillsExperienceCubit>()..fetchSkillsExperience(),
      child: BlocConsumer<SkillsExperienceCubit, SkillsExperienceState>(
        listener: (context, state)  {
          if (state is SkillsExperienceLoaded) {
            if (!mounted) return;
            setState(() => _populateFields(state.skillsExperience));
          }
          if (state is SkillsExperienceUpdated) {
            BridgeXSnackBar.showSuccess(
              context: context,
              message: 'Skills & Experience updated successfully',

            );
            if (context.mounted) {
              context.pop();
            }
          }
          if (state is SkillsExperienceError &&
              _originalSkillsExperience != null) {
            BridgeXSnackBar.showError(context: context, message: state.message);
          }
        },
        builder: (context, state) {
          final isLoading = state is SkillsExperienceInitial ||
              state is SkillsExperienceLoading;
          final isUpdating = state is SkillsExperienceUpdating;

          return ScrollNavListener(
            controller: _scrollController,
            child: Scaffold(
              backgroundColor: context.colors.scaffoldBg,
              body: Stack(
                children: [
                  const BridgeXBackgroundGears(),
                  SafeArea(
                    child: _buildBody(context, isLoading, isUpdating, state),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
