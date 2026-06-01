import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/team_setting_widget/section_header.dart';
import 'package:bridge_x/feature/skills_and_experience/presentation/widget/skills_and_experience_widget/dashed_border_painter.dart';
import 'package:flutter/material.dart';

class TeamProjectControl extends StatelessWidget {
  const TeamProjectControl({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: AppStrings.projectControl.toUpperCase()),
        VerticalSpacing(AppSpacing.spacing8),
        CustomPaint(
          painter: DashedBorderPainter(
            color: context.colors.primary.withValues(alpha: 0.3),
            borderRadius: AppSpacing.radius16,
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppSpacing.spacing20),
            decoration: BoxDecoration(
              color: context.colors.primaryLight.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(AppSpacing.radius16),
            ),
            child: Column(
              children: [
                Text(
                  AppStrings.projectCompletionConfirmation,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.textPrimary,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                VerticalSpacing(AppSpacing.spacing16),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(AppStrings.projectCompletionSubmitted),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: AppSpacing.spacing12,
                    ),
                    decoration: BoxDecoration(
                      color: context.colors.primaryLight,
                      borderRadius: BorderRadius.circular(AppSpacing.radius12),
                      border: Border.all(
                        color: context.colors.primary.withValues(alpha: 0.2),
                        width: 1.0,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        AppStrings.submitProjectAsCompleted,
                        style: context.textTheme.titleMedium?.copyWith(
                          color: context.colors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
