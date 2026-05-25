import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';

import 'package:bridge_x/core/widget/layout/bridge_x_chip.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';

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
            final isSelected = selectedIndex == index;
            return BridgeXChip(
              label: _categories[index],
              isSelected: isSelected,
              onTap: () => onChanged(index),
              selectedBackgroundColor: context.colors.secondary,
              backgroundColor: context.colors.divider,
              selectedBorderColor: context.colors.secondary,
              borderColor: context.colors.divider,
              selectedTextColor: Colors.white,
              textColor: context.colors.textPrimary,
              textStyle: AppTextStyles.labelSmall,
            );
          }),
        ),
      ],
    );
  }
}
