import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/dashboard_screen_widgets/submit_button.dart';
import 'package:flutter/material.dart';

class CompletionCard extends StatelessWidget {
  final int projectId;

  const CompletionCard({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.spacing20),
      decoration: BoxDecoration(
        color: context.colors.primary.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(AppSpacing.radius18),
        border: Border.all(
          color: context.colors.divider,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: AppSpacing.spacing32,
                height: AppSpacing.spacing32,
                decoration: BoxDecoration(
                  color: context.colors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  color: context.colors.surface,
                  size: AppSpacing.fontSize18,
                ),
              ),
              HorizontalSpacing(AppSpacing.spacing16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.projectCompletion,
                      style: AppTextStyles.titleLarge.copyWith(
                        color: context.colors.textPrimary,
                      ),
                    ),
                    VerticalSpacing(AppSpacing.spacing4),
                    Text(
                      AppStrings.markProjectAsCompletedDesc,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: context.colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          VerticalSpacing(AppSpacing.spacing16),
          SubmitButton(projectId: projectId),
        ],
      ),
    );
  }
}
