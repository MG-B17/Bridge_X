import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/theme_extension.dart';
import 'package:bridge_x/feature/layout/widgets/bottom_nav_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final selectedColor = context.colors.primary;
    final unselectedColor = context.colors.textHint;
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: context.colors.textPrimary.withValues(alpha: .1),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, -4),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
          child: BottomAppBar(
            color: context.colors.surface,
            notchMargin: 0,
            height: 75.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                bottomNavItem(
                  icon: Icons.home_rounded,
                  label: AppStrings.home,
                  isSelected: navigationShell.currentIndex == 0,
                  onTap: () {
                    navigationShell.goBranch(0);
                  },
                  selectedColor: selectedColor,
                  unselectedColor: unselectedColor,
                ),
                bottomNavItem(
                  icon: Icons.chat_bubble_outline_rounded,
                  label: AppStrings.chat,
                  isSelected: navigationShell.currentIndex == 1,
                  onTap: () {
                    navigationShell.goBranch(1);
                  },
                  selectedColor: selectedColor,
                  unselectedColor: unselectedColor,
                ),
                bottomNavItem(
                  icon: Icons.folder_outlined,
                  label: AppStrings.projects,
                  isSelected: navigationShell.currentIndex == 2,
                  onTap: () {
                    navigationShell.goBranch(2);
                  },
                  selectedColor: selectedColor,
                  unselectedColor: unselectedColor,
                ),
                bottomNavItem(
                  icon: Icons.person_outline_rounded,
                  label: AppStrings.profile,
                  isSelected: navigationShell.currentIndex == 3,
                  onTap: () {
                    navigationShell.goBranch(3);
                  },
                  selectedColor: selectedColor,
                  unselectedColor: unselectedColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
