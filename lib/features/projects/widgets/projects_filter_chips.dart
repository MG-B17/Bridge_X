import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/extensions.dart';

class ProjectsFilterChips extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onSelected;

  const ProjectsFilterChips({
    super.key,
    required this.selectedFilter,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: context.spacing.sm,
      runSpacing: context.spacing.sm,
      children: [
        _buildChip(context, 'All'),
        _buildChip(context, 'Ongoing'),
        _buildChip(context, 'Completed'),
      ],
    );
  }

  Widget _buildChip(BuildContext context, String label) {
    final bool isSelected = selectedFilter == label;
    return InkWell(
      onTap: () => onSelected(label),
      borderRadius: BorderRadius.circular(context.spacing.radiusCard),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? context.colors.primary : context.colors.textHint.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(context.spacing.radiusCard),
        ),
        child: Text(
          label,
          style: context.bodyMedium.copyWith(
            color: isSelected ? Colors.white : context.colors.textPrimary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
