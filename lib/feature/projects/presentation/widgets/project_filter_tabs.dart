import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectFilterTabs extends StatelessWidget {
  const ProjectFilterTabs({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  static const _filters = [
    AppStrings.all,
    AppStrings.ongoing,
    AppStrings.completed,
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_filters.length, (index) {
        final isSelected = selectedIndex == index;
        return Padding(
          padding: EdgeInsets.only(right: AppSpacing.sm),
          child: _FilterChip(
            label: _filters[index],
            isSelected: isSelected,
            onTap: () => onChanged(index),
          ),
        );
      }),
    );
  }
}

// ── Single filter chip ──────────────────────────────────────────────────────
class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: 18.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: isSelected ? colors.primary : colors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
          border: Border.all(
            color: isSelected ? colors.primary : colors.divider,
            width: 1.2,
          ),
          boxShadow: isSelected ? AppSpacing.subtleShadow : null,
        ),
        child: Text(
          label,
          style: AppTextStyles.titleMedium.copyWith(
            color: isSelected ? Colors.white : colors.textPrimary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }
}
