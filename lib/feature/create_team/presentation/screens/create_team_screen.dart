import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/bridge_x_button.dart';
import 'package:bridge_x/core/widget/bridge_x_text_form_field.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:bridge_x/feature/create_team/presentation/widgets/category_selection_section.dart';
import 'package:bridge_x/feature/create_team/presentation/widgets/leader_banner.dart';
import 'package:bridge_x/feature/create_team/presentation/widgets/project_description_field.dart';
import 'package:bridge_x/feature/create_team/presentation/widgets/required_roles_section.dart';
import 'package:bridge_x/feature/create_team/presentation/widgets/team_members_section.dart';
import 'package:bridge_x/feature/create_team/presentation/widgets/team_type_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
      backgroundColor: context.colors.scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            // ── Scrollable content ──
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.md,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Back button ──
                    _BackButton(onTap: () => context.pop()),
                    VerticalSpacing(AppSpacing.sm),

                    // ── Leader banner ──
                    const LeaderBanner(),
                    VerticalSpacing(AppSpacing.lg),

                    // ── Team Type ──
                    TeamTypeSelector(
                      selectedIndex: _selectedTeamType,
                      onChanged: (index) =>
                          setState(() => _selectedTeamType = index),
                    ),
                    VerticalSpacing(AppSpacing.lg),

                    // ── Team Name ──
                    BridgeXTextFormField(
                      label: AppStrings.teamName,
                      hint: AppStrings.teamNameHint,
                      controller: _teamNameController,
                    ),
                    VerticalSpacing(AppSpacing.md),

                    // ── Github URL ──
                    BridgeXTextFormField(
                      label: AppStrings.githubUrl,
                      hint: AppStrings.urlHint,
                      controller: _githubUrlController,
                      keyboardType: TextInputType.url,
                    ),
                    VerticalSpacing(AppSpacing.md),

                    // ── Project Description ──
                    ProjectDescriptionField(
                      controller: _descriptionController,
                    ),
                    VerticalSpacing(AppSpacing.lg),

                    // ── Category Selection ──
                    CategorySelectionSection(
                      selectedIndex: _selectedCategory,
                      onChanged: (index) =>
                          setState(() => _selectedCategory = index),
                    ),
                    VerticalSpacing(AppSpacing.lg),

                    // ── Required Roles ──
                    RequiredRolesSection(
                      roles: _selectedRoles,
                      onRoleRemoved: (role) =>
                          setState(() => _selectedRoles.remove(role)),
                      onRoleAdded: (role) =>
                          setState(() => _selectedRoles.add(role)),
                    ),
                    VerticalSpacing(AppSpacing.lg),

                    // ── Team Members ──
                    const TeamMembersSection(),
                    VerticalSpacing(AppSpacing.md),
                  ],
                ),
              ),
            ),

            // ── Bottom Create Team button ──
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: 12.h,
              ),
              decoration: BoxDecoration(
                color: context.colors.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: BridgeXButton(
                  text: '${AppStrings.createTeam} 🚀',
                  onTap: () {
                    // TODO: Handle create team action
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Back button ─────────────────────────────────────────────────────────────
class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.only(top: 4.h, bottom: 4.h),
        child: Icon(
          Icons.arrow_back,
          color: context.colors.textPrimary,
          size: 24.sp,
        ),
      ),
    );
  }
}
