import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';

import 'category_selection_chip.dart';

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
        VerticalSpacing(AppSpacing.spacing8),
        Wrap(
          spacing: AppSpacing.spacing8,
          runSpacing: AppSpacing.height8,
          children: List.generate(_categories.length, (index) {
            return CategorySelectionChip(
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
