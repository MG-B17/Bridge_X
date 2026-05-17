import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        Icon(icon, color: isSelected ? selectedColor : unselectedColor, size: 22.sp),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? selectedColor : unselectedColor,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            fontSize: 11.sp,
          ),
        ),
      ],
    ),
  );
}
