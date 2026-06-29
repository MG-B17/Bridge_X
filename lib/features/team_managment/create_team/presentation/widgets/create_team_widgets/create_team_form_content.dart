import 'package:bridge_x/core/animation/bottom_nav_bar_animation/controller/scroll_cubit.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/validator.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_back_button.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_button.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_tip_banner.dart';
import 'package:bridge_x/core/widget/inputs/bridge_x_text_form_field.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/team_managment/create_team/presentation/controller/create_team_cubit.dart';
import 'package:bridge_x/features/team_managment/create_team/presentation/controller/create_team_state.dart';
import 'package:bridge_x/features/team_managment/create_team/presentation/widgets/create_team_widgets/category_selection_section.dart';
import 'package:bridge_x/features/team_managment/create_team/presentation/widgets/create_team_widgets/project_description_field.dart';
import 'package:bridge_x/features/team_managment/create_team/presentation/widgets/create_team_widgets/required_roles_section.dart';
import 'package:bridge_x/features/team_managment/create_team/presentation/widgets/create_team_widgets/roles_error_text.dart';
import 'package:bridge_x/features/team_managment/create_team/presentation/widgets/create_team_widgets/team_members_section.dart';
import 'package:bridge_x/features/team_managment/create_team/presentation/widgets/create_team_widgets/team_type_selector.dart';
import 'package:bridge_x/features/team_managment/utils/create_team_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateTeamFormContent extends StatefulWidget {
  const CreateTeamFormContent({super.key});

  @override
  State<CreateTeamFormContent> createState() => _CreateTeamFormContentState();
}

class _CreateTeamFormContentState extends State<CreateTeamFormContent> {
  final _formKey = GlobalKey<FormState>();
  final _teamNameController = TextEditingController();
  final _githubUrlController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _teamNameController.dispose();
    _githubUrlController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BridgeXBackButton(
            onTap: () {
              context.read<ScrollCubit>().show();
              context.pop();
            },
          ),
          VerticalSpacing(AppSpacing.spacing24),
          const BridgeXTipBanner(message: CreateTeamStrings.youAreTeamLeader),
          VerticalSpacing(AppSpacing.spacing14),
          BlocBuilder<CreateTeamCubit, CreateTeamState>(
            buildWhen: (previous, current) =>
                previous.selectedTeamType != current.selectedTeamType,
            builder: (context, state) {
              return TeamTypeSelector(
                selectedIndex: state.selectedTeamType,
                onChanged: (index) => context
                    .read<CreateTeamCubit>()
                    .changeTeamType(index: index),
              );
            },
          ),
          VerticalSpacing(AppSpacing.spacing24),
          BridgeXTextFormField(
            label: CreateTeamStrings.teamName,
            hint: CreateTeamStrings.teamNameHint,
            controller: _teamNameController,
            validator: (value) =>
                AppValidator.required(value, CreateTeamStrings.teamName),
          ),
          VerticalSpacing(AppSpacing.spacing16),
          BridgeXTextFormField(
            label: CreateTeamStrings.githubUrl,
            hint: CreateTeamStrings.urlHint,
            controller: _githubUrlController,
            keyboardType: TextInputType.url,
            validator: (value) => AppValidator.url(value),
          ),
          VerticalSpacing(AppSpacing.spacing16),
          ProjectDescriptionField(
            controller: _descriptionController,
            validator: (value) => AppValidator.projectDescription(
              value,
              CreateTeamStrings.projectDescription,
            ),
          ),
          VerticalSpacing(AppSpacing.spacing24),
          BlocBuilder<CreateTeamCubit, CreateTeamState>(
            buildWhen: (previous, current) =>
                previous.selectedCategory != current.selectedCategory,
            builder: (context, state) {
              return CategorySelectionSection(
                selectedIndex: state.selectedCategory,
                onChanged: (index) => context
                    .read<CreateTeamCubit>()
                    .changeCategory(index: index),
              );
            },
          ),
          VerticalSpacing(AppSpacing.spacing24),
          BlocBuilder<CreateTeamCubit, CreateTeamState>(
            builder: (context, state) {
              return RequiredRolesSection(
                roles: state.selectedRoles,
                hasError: state.showRolesError,
                onRoleRemoved: (role) {
                  context.read<CreateTeamCubit>().removeRole(role: role);
                },
                onRoleAdded: (role) {
                  context.read<CreateTeamCubit>().addRole(role: role);
                },
              );
            },
          ),
          BlocBuilder<CreateTeamCubit, CreateTeamState>(
            buildWhen: (previous, current) =>
                previous.showRolesError != current.showRolesError,
            builder: (context, state) {
              if (state.showRolesError) {
                return const RolesErrorText();
              }
              return const SizedBox.shrink();
            },
          ),
          VerticalSpacing(AppSpacing.spacing24),
          BlocBuilder<CreateTeamCubit, CreateTeamState>(
            buildWhen: (previous, current) =>
                previous.selectedTeamType != current.selectedTeamType,
            builder: (context, state) {
              if (state.selectedTeamType == 0) {
                return Column(
                  children: [
                    const TeamMembersSection(),
                    VerticalSpacing(AppSpacing.spacing16),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
          BridgeXButton(
            text: CreateTeamStrings.createTeam,
            onTap: () {
              final cubit = context.read<CreateTeamCubit>();
              final currentState = cubit.state;
              final isFormValid = _formKey.currentState?.validate() ?? false;
              final isRolesValid = currentState.selectedRoles.isNotEmpty;

              cubit.setShowRolesError(!isRolesValid);

              if (isFormValid && isRolesValid) {
                cubit.createTeam(
                  name: _teamNameController.text,
                  description: _descriptionController.text,
                  githubUrl: _githubUrlController.text,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
