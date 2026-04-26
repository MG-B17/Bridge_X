import 'package:flutter/material.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/navigation/app_route_constant.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/bridge_dialogs.dart';
import 'profile_menu_item_widget.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
          border: Border.all(color: context.colors.divider),
        ),
        child: Column(
          children: [
            ProfileMenuItemWidget(
              title: AppStrings.myTasks,
              icon: Icons.check_circle_outline_rounded,
              iconBgColor: const Color(0xFFEFF6FF),
              iconColor: const Color(0xFF3B82F6),
              badgeCount: 3,
              onTap: () => context.push(AppRouteConstant.workspace),
            ),
            ProfileMenuItemWidget(
              title: AppStrings.myProjects,
              icon: Icons.hub_outlined,
              iconBgColor: const Color(0xFFEFF6FF),
              iconColor: const Color(0xFF3B82F6),
              onTap: () => context.push(AppRouteConstant.workspace),
            ),
            ProfileMenuItemWidget(
              title: AppStrings.skillsAndExperience,
              icon: Icons.psychology_outlined,
              iconBgColor: const Color(0xFFEFF6FF),
              iconColor: const Color(0xFF3B82F6),
              onTap: () => context.push(AppRouteConstant.level),
            ),
            ProfileMenuItemWidget(
              title: AppStrings.settings,
              icon: Icons.settings_outlined,
              iconBgColor: const Color(0xFFF3F4F6),
              iconColor: const Color(0xFF6B7280),
              onTap: () {},
            ),
            ProfileMenuItemWidget(
              title: AppStrings.logout,
              icon: Icons.logout_rounded,
              iconBgColor: const Color(0xFFFEF2F2),
              iconColor: const Color(0xFFEF4444),
              isDestructive: true,
              showDivider: false,
              onTap: () => BridgeDialogs.showLogout(context),
            ),
          ],
        ),
      ),
    );
  }
}
