import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategorySelectionSection extends StatelessWidget {
  const CategorySelectionSection({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  static const _categories = [
    AppStrings.development,
    AppStrings.design,
    AppStrings.marketing,
    AppStrings.research,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.categorySelection,
          style: context.textTheme.labelMedium?.copyWith(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        VerticalSpacing(AppSpacing.sm),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: List.generate(_categories.length, (index) {
            return _CategoryChip(
              label: _categories[index],
              isSelected: selectedIndex == index,
              onTap: () => onChanged(index),
            );
          }),
        ),
      ],
    );
  }
}

// ── Single category chip ────────────────────────────────────────────────────
class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
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
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: isSelected ? colors.primary : colors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
          border: Border.all(
            color: isSelected ? colors.primary : colors.divider,
            width: 1.2,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: isSelected ? Colors.white : colors.textPrimary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
