import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/theme_extension.dart';
import 'package:bridge_x/core/utils/app_shadow.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/feature/layout/widgets/bottom_nav_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BridgeXBottomNavBar extends StatelessWidget {
  const BridgeXBottomNavBar({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final selectedColor = context.colors.primary;
    final unselectedColor = context.colors.textHint;

    return SafeArea(
      top: false,
      child: Container(
        height: AppSpacing.bottomNavBarHeight,
        decoration: BoxDecoration(
          color: context.colors.surface,
          boxShadow: AppShadow.bottomNavBar(
            context.colors.textPrimary.withValues(alpha: .1),
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSpacing.radius30),
            topRight: Radius.circular(AppSpacing.radius30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            bottomNavItem(
              icon: Icons.home_rounded,
              label: AppStrings.home,
              isSelected: navigationShell.currentIndex == 0,
              onTap: () => navigationShell.goBranch(0),
              selectedColor: selectedColor,
              unselectedColor: unselectedColor,
            ),
            bottomNavItem(
              icon: Icons.chat_bubble_outline_rounded,
              label: AppStrings.chat,
              isSelected: navigationShell.currentIndex == 1,
              onTap: () => navigationShell.goBranch(1),
              selectedColor: selectedColor,
              unselectedColor: unselectedColor,
            ),
            bottomNavItem(
              icon: Icons.folder_outlined,
              label: AppStrings.projects,
              isSelected: navigationShell.currentIndex == 2,
              onTap: () => navigationShell.goBranch(2),
              selectedColor: selectedColor,
              unselectedColor: unselectedColor,
            ),
            bottomNavItem(
              icon: Icons.person_outline_rounded,
              label: AppStrings.profile,
              isSelected: navigationShell.currentIndex == 3,
              onTap: () => navigationShell.goBranch(3),
              selectedColor: selectedColor,
              unselectedColor: unselectedColor,
            ),
          ],
        ),
      ),
    );
  }
}