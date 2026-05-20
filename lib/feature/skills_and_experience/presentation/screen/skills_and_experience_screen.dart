import 'package:bridge_x/core/animation/bottom_nav_bar_animation/widget/scroller_listener.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/bridge_x_background_gears.dart';
import 'package:bridge_x/core/widget/bridge_x_button.dart';
import 'package:bridge_x/core/widget/bridge_x_screen_header.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../widget/skills_and_experience_widget/experience_description_section.dart';
import '../widget/skills_and_experience_widget/experience_level_section.dart';
import '../widget/skills_and_experience_widget/projects_section.dart';
import '../widget/skills_and_experience_widget/skills_section.dart';

class SkillsAndExperienceScreen extends StatefulWidget {
  const SkillsAndExperienceScreen({super.key});

  @override
  State<SkillsAndExperienceScreen> createState() => _SkillsAndExperienceScreenState();
}

class _SkillsAndExperienceScreenState extends State<SkillsAndExperienceScreen> {
  late final TextEditingController _experienceController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _experienceController = TextEditingController(text: AppStrings.experienceDesc);
  }

  @override
  void dispose() {
    _experienceController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollNavListener(
      controller: _scrollController,
      child: Scaffold(
        backgroundColor: context.colors.scaffoldBg,
        body: Stack(
          children: [
            const BridgeXBackgroundGears(),
            SafeArea(
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
                    // ── Screen Header ──
                    const BridgeXScreenHeader(
                      title: AppStrings.skillsAndExperience,
                    ),
                    VerticalSpacing(AppSpacing.spacing24),

                    // ── Experience Level Card ──
                    const ExperienceLevelSection(),
                    VerticalSpacing(AppSpacing.spacing24),

                    // ── Skills Card ──
                    const SkillsSection(),
                    VerticalSpacing(AppSpacing.spacing24),

                    // ── Experience Description Card ──
                    ExperienceDescriptionSection(controller: _experienceController),
                    VerticalSpacing(AppSpacing.spacing24),

                    // ── Projects Section ──
                    const ProjectsSection(),
                    VerticalSpacing(AppSpacing.spacing32),

                    // ── Save Changes ──
                    BridgeXButton(
                      text: AppStrings.saveChanges,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    VerticalSpacing(AppSpacing.spacing16),

                    // ── Cancel ──
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
            ),
          ],
        ),
      ),
    );
  }
}
