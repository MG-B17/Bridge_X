import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/create_task/create_task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrioritySelector extends StatelessWidget {
  const PrioritySelector({super.key, required this.selected});

  final int selected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Wrap(
      spacing: AppSpacing.spacing6,
      runSpacing: AppSpacing.spacing6,
      children: [
        _buildChip(context, AppStrings.priorityLow, 1, colors),
        _buildChip(context, AppStrings.priorityMed, 2, colors),
        _buildChip(context, AppStrings.priorityHigh, 3, colors),
      ],
    );
  }

  Widget _buildChip(BuildContext context, String label, int value, dynamic colors) {
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
