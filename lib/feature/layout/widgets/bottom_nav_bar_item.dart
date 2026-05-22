import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';

Widget bottomNavItem({
  required IconData icon,
  required String label,
  required bool isSelected,
  required VoidCallback onTap,
  required Color selectedColor,
  required Color unselectedColor,
}) {
  return GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isSelected ? selectedColor : unselectedColor,
          size: AppSpacing.fontSize22,
        ),
        VerticalSpacing(AppSpacing.height4),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? selectedColor : unselectedColor,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            fontSize: AppSpacing.fontSize11,
          ),
        ),
      ],
    ),
  );
}
