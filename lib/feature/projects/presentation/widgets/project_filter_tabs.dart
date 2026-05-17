import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:flutter/material.dart';

import 'project_filter_chip.dart';

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
          child: ProjectFilterChip(
            label: _filters[index],
            isSelected: isSelected,
            onTap: () => onChanged(index),
          ),
        );
      }),
    );
  }
}
