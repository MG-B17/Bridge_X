import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_gradient.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/dashboard/domain/entities/project_detail_entity.dart';
import 'package:flutter/material.dart';

class ProjectProgressItem extends StatelessWidget {
  const ProjectProgressItem({
    super.key,
    required this.project,
    this.isLast = false,
  });

  final ProjectDetailEntity project;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final percentage = project.completionPercentage.round();

    return Padding(
      padding: EdgeInsets.only(
        bottom: isLast ? 0 : AppSpacing.spacing24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            project.projectTitle,
            style: AppTextStyles.headlineMedium.copyWith(
              color: context.colors.textPrimary,
              fontSize: AppSpacing.fontSize18,
              fontWeight: FontWeight.bold,
            ),
          ),
          VerticalSpacing(AppSpacing.spacing6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$percentage% completed',
                style: AppTextStyles.labelSmall.copyWith(
                  color: context.colors.textSecondary,
                  fontSize: AppSpacing.fontSize12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '$percentage%',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: context.colors.textPrimary,
                  fontSize: AppSpacing.fontSize12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          VerticalSpacing(AppSpacing.spacing8),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
            child: SizedBox(
              height: AppSpacing.height8,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    color: context.colors.textHint,
                  ),
                  FractionallySizedBox(
                    widthFactor: (project.completionPercentage / 100).clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: AppGradient.barFill,
                        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
