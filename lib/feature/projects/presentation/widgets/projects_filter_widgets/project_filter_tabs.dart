import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:flutter/material.dart';

import 'package:bridge_x/core/widget/layout/bridge_x_chip.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_shadow.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
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
          child: BridgeXChip(
            label: _filters[index],
            isSelected: isSelected,
            onTap: () => onChanged(index),
            selectedBackgroundColor: context.colors.primary,
            backgroundColor: context.colors.surface,
            selectedBorderColor: context.colors.primary,
            borderColor: context.colors.divider,
            selectedTextColor: Colors.white,
            textColor: context.colors.textPrimary,
            borderRadius: AppSpacing.radiusPill,
            boxShadow: AppShadow.subtle,
            textStyle: AppTextStyles.titleMedium.copyWith(fontSize: 13.sp),
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
          ),
        );
      }),
    );
  }
}
