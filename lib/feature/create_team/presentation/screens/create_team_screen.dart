import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/bridge_x_back_button.dart';
import 'package:bridge_x/core/widget/bridge_x_button.dart';
import 'package:bridge_x/core/widget/bridge_x_text_form_field.dart';
import 'package:bridge_x/core/widget/bridge_x_tip_banner.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:bridge_x/feature/create_team/presentation/widgets/category_selection_section.dart';
import 'package:bridge_x/feature/create_team/presentation/widgets/project_description_field.dart';
import 'package:bridge_x/feature/create_team/presentation/widgets/required_roles_section.dart';
import 'package:bridge_x/feature/create_team/presentation/widgets/team_members_section.dart';
import 'package:bridge_x/feature/create_team/presentation/widgets/team_type_selector.dart';
import 'package:flutter/material.dart';

class CreateTeamScreen extends StatefulWidget {
  const CreateTeamScreen({super.key});

  @override
  State<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  final _teamNameController = TextEditingController();
  final _githubUrlController = TextEditingController();
  final _descriptionController = TextEditingController();

  int _selectedTeamType = 0; // 0 = Private, 1 = Public
  int _selectedCategory = 0;
  final List<String> _selectedRoles = ['Frontend', 'UX Designer'];

  @override
  void dispose() {
    _teamNameController.dispose();
    _githubUrlController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.spacing16,
                  vertical: AppSpacing.spacing16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BridgeXBackButton(),
                    VerticalSpacing(AppSpacing.spacing24),
                    const BridgeXTipBanner(message: AppStrings.youAreTeamLeader),
                    VerticalSpacing(AppSpacing.spacing14),
                    TeamTypeSelector(
                      selectedIndex: _selectedTeamType,
                      onChanged: (index) => setState(() => _selectedTeamType = index),
                    ),
                    VerticalSpacing(AppSpacing.spacing24),
                    BridgeXTextFormField(
                      label: AppStrings.teamName,
                      hint: AppStrings.teamNameHint,
                      controller: _teamNameController,
                    ),
                    VerticalSpacing(AppSpacing.spacing16),
                    BridgeXTextFormField(
                      label: AppStrings.githubUrl,
                      hint: AppStrings.urlHint,
                      controller: _githubUrlController,
                      keyboardType: TextInputType.url,
                    ),
                    VerticalSpacing(AppSpacing.spacing16),
                    ProjectDescriptionField(controller: _descriptionController),
                    VerticalSpacing(AppSpacing.spacing24),
                    CategorySelectionSection(
                      selectedIndex: _selectedCategory,
                      onChanged: (index) => setState(() => _selectedCategory = index),
                    ),
                    VerticalSpacing(AppSpacing.spacing24),
                    RequiredRolesSection(
                      roles: _selectedRoles,
                      onRoleRemoved: (role) => setState(() => _selectedRoles.remove(role)),
                      onRoleAdded: (role) => setState(() => _selectedRoles.add(role)),
                    ),
                    VerticalSpacing(AppSpacing.spacing24),
                    const TeamMembersSection(),
                    VerticalSpacing(AppSpacing.spacing16),
                    BridgeXButton(
                      text: '${AppStrings.createTeam} 🚀',
                      onTap: () {
                        // TODO: Handle create team action
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
