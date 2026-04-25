import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/bridge_app_button.dart';
import '../../../../core/widgets/v_space.dart';
import '../widgets/skills_experience_widgets.dart';

class SkillsExperienceScreen extends StatefulWidget {
  const SkillsExperienceScreen({super.key});

  @override
  State<SkillsExperienceScreen> createState() =>
      _SkillsExperienceScreenState();
}

class _SkillsExperienceScreenState extends State<SkillsExperienceScreen> {
  int _selectedLevel = 1; // Junior
  final List<String> _skills = ['Flutter', 'React', 'UI/UX'];
  bool _showAddProject = false;

  final _projectNameController = TextEditingController();
  final _roleController = TextEditingController();

  final List<Map<String, String>> _projects = [
    {'name': 'Nova Dashboards', 'role': 'Lead Product Designer'},
  ];

  @override
  void dispose() {
    _projectNameController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.scaffoldBg,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildScreenHeader(context),
                  VSpace(context.spacing.lg),
                  ExperienceLevelSelector(
                    selectedIndex: _selectedLevel,
                    onChanged: (index) {
                      setState(() => _selectedLevel = index);
                    },
                  ),
                  VSpace(context.spacing.xl),
                  SkillsEditor(
                    skills: _skills,
                    onAddSkill: _onAddSkill,
                    onRemoveSkill: _onRemoveSkill,
                  ),
                  VSpace(context.spacing.xl),
                  const ExperienceCard(
                    text:
                        'Experienced mobile developer with a focus on creating performant, beautiful cross-platform applications. I have spent the last 3 years mastering Flutter and React, contributing to several high-profile fintech and social networking projects. I\'m passionate about clean architecture and pixel-perfect UI implementation.',
                  ),
                  VSpace(context.spacing.xl),
                  _buildProjectsSection(context),
                  VSpace(context.spacing.xxl),
                ],
              ),
            ),
          ),
          _buildBottomActions(context),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: context.colors.textPrimary),
        onPressed: () => context.pop(),
      ),
    );
  }

  Widget _buildScreenHeader(BuildContext context) {
    return Text(
      AppStrings.skillsAndExperience,
      style: context.displayLarge.copyWith(
        color: context.colors.textPrimary,
        fontSize: 28.sp,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget _buildProjectsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Projects',
              style: context.bodyLarge.copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() => _showAddProject = true);
              },
              child: Text(
                AppStrings.addProject,
                style: context.bodyMedium.copyWith(
                  color: context.colors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        VSpace(context.spacing.md),
        ..._projects.map((project) {
          final index = _projects.indexOf(project);
          return ProjectItem(
            name: project['name']!,
            role: project['role']!,
            onEdit: () {},
            onDelete: () {
              setState(() => _projects.removeAt(index));
            },
          );
        }),
        if (_showAddProject) ...[
          VSpace(context.spacing.sm),
          AddProjectForm(
            nameController: _projectNameController,
            roleController: _roleController,
            onConfirm: _onConfirmAddProject,
            onCancel: () {
              setState(() {
                _showAddProject = false;
                _projectNameController.clear();
                _roleController.clear();
              });
            },
          ),
        ],
      ],
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.spacing.xl),
      decoration: BoxDecoration(color: context.colors.scaffoldBg),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppButton(
              label: AppStrings.saveChanges,
              onPressed: _onSave,
            ),
            VSpace(context.spacing.md),
            GestureDetector(
              onTap: () => context.pop(),
              child: Text(
                AppStrings.cancel,
                style: context.bodyMedium.copyWith(
                  color: context.colors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onAddSkill() {
    // TODO: Show skill picker dialog
  }

  void _onRemoveSkill(int index) {
    setState(() => _skills.removeAt(index));
  }

  void _onConfirmAddProject() {
    final name = _projectNameController.text.trim();
    final role = _roleController.text.trim();
    if (name.isNotEmpty && role.isNotEmpty) {
      setState(() {
        _projects.add({'name': name, 'role': role});
        _showAddProject = false;
        _projectNameController.clear();
        _roleController.clear();
      });
    }
  }

  void _onSave() {
    // TODO: Persist changes
    context.pop();
  }
}
