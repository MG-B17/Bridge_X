import 'package:flutter/material.dart';
import '../../../core/utils/extensions.dart';
import '../widgets/custom_nav_item.dart';

class MainLayoutPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainLayoutPage({super.key, required this.navigationShell});

  void _onItemTapped(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.spacing.md,
          vertical: context.spacing.sm,
        ),
        decoration: BoxDecoration(
          color: context.colors.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomNavItem(
                index: 0,
                icon: Icons.home_filled,
                label: 'Home',
                isActive: navigationShell.currentIndex == 0,
                onTap: _onItemTapped,
              ),
              CustomNavItem(
                index: 1,
                icon: Icons.chat_outlined,
                label: 'Chat',
                isActive: navigationShell.currentIndex == 1,
                onTap: _onItemTapped,
              ),
              CustomNavItem(
                index: 2,
                icon: Icons.folder_outlined,
                label: 'Projects',
                isActive: navigationShell.currentIndex == 2,
                onTap: _onItemTapped,
              ),
              CustomNavItem(
                index: 3,
                icon: Icons.person_outline,
                label: 'Profile',
                isActive: navigationShell.currentIndex == 3,
                onTap: _onItemTapped,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
