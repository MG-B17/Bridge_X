import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';

class ExperienceLevelSection extends StatelessWidget {
  const ExperienceLevelSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        border: Border.all(color: context.colors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.star_border, color: context.colors.textSecondary, size: 20),
              HorizontalSpacing(AppSpacing.xs),
              Text(
                AppStrings.experienceLevel.toUpperCase(),
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colors.textSecondary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          VerticalSpacing(AppSpacing.md),
          Row(
            children: [
              _buildChip(context, AppStrings.beginner, false),
              HorizontalSpacing(AppSpacing.sm),
              _buildChip(context, AppStrings.junior, true),
              HorizontalSpacing(AppSpacing.sm),
              _buildChip(context, AppStrings.senior, false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChip(BuildContext context, String label, bool isSelected) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          color: isSelected ? context.colors.surface : context.colors.primary.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
          border: Border.all(
            color: isSelected ? context.colors.primary : Colors.transparent,
            width: isSelected ? 1.5 : 0,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: context.textTheme.bodyMedium?.copyWith(
            color: isSelected ? context.colors.primary : context.colors.textSecondary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
