import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/app_color_schema.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/features/team_managment/task_management/presentation/bloc/create_task/create_task_cubit.dart';
import 'package:bridge_x/features/team_managment/utils/task_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrioritySelector extends StatelessWidget {
  const PrioritySelector({super.key, required this.selected});

  final String selected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Wrap(
      spacing: AppSpacing.spacing6,
      runSpacing: AppSpacing.spacing6,
      children: [
        _buildChip(context, TaskStrings.priorityLow, 'low', colors),
        _buildChip(context, TaskStrings.priorityMed, 'medium', colors),
        _buildChip(context, TaskStrings.priorityHigh, 'high', colors),
      ],
    );
  }

  Widget _buildChip(BuildContext context, String label, String value, AppColorScheme colors) {
    final isSelected = value == selected;
    return GestureDetector(
      onTap: () => context.read<CreateTaskCubit>().setPriority(value),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing12, vertical: AppSpacing.spacing8),
        decoration: BoxDecoration(
          color: isSelected ? colors.secondary : colors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
          border: Border.all(color: isSelected ? colors.secondary : colors.divider),
        ),
        child: Text(label, style: AppTextStyles.labelSmall.copyWith(color: isSelected ? colors.surface : colors.textSecondary, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
