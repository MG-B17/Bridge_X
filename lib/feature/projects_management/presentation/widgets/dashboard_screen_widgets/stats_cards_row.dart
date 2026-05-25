import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/dashboard/project_dashboard_entity.dart';
import 'package:flutter/material.dart';

class StatsCardsRow extends StatelessWidget {
  final ProjectDashboardEntity project;

  const StatsCardsRow({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            backgroundColor: context.colors.onGoingColor.withValues(alpha: 0.3),
            icon: Icons.task_alt,
            iconColor: context.colors.burgundy,
            value: project.pendingTasks.toString().padLeft(2, '0'),
            label: AppStrings.tasksPending.toUpperCase(),
          ),
        ),
        HorizontalSpacing(AppSpacing.spacing16),
        Expanded(
          child: _StatCard(
            backgroundColor: context.colors.primary.withValues(alpha: 0.19),
            icon: Icons.people,
            iconColor: context.colors.primary,
            value: project.totalMembers.toString().padLeft(2, '0'),
            label: AppStrings.activeMembers.toUpperCase(),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.backgroundColor,
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.spacing20, horizontal: AppSpacing.spacing16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppSpacing.radius16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: AppSpacing.fontSize30),
          VerticalSpacing(AppSpacing.spacing8),
          Text(
            value,
            style: AppTextStyles.displayLarge.copyWith(
              color: context.colors.textPrimary,
            ),
          ),
          VerticalSpacing(AppSpacing.spacing2),
          Text(
            label,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.labelSmall.copyWith(
              color: context.colors.textSecondary,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
