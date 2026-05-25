import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/bridge_x_divider.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'profile_menu_item.dart';
import 'logout_dialog.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.primary.withValues(alpha: 0.05), // Light background for the menu block
        borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
      ),
      child: Column(
        children: [
          VerticalSpacing(AppSpacing.sm),
          ProfileMenuItem(
            label: AppStrings.myTasks,
            icon: Icons.task_alt_outlined,
            badgeCount: 3,
            onTap: () {
              context.goNamed(BridegeXRouteNames.myTasks);
            },
          ),
          BridgeXDivider(height: 16, indent: 24, endIndent: 24, color: context.colors.divider),
          ProfileMenuItem(
            label: AppStrings.skillsAndExperience,
            icon: Icons.psychology_outlined,
            onTap: () {
              context.goNamed(BridegeXRouteNames.skillsAndExperience);
            },
          ),
          BridgeXDivider(height: 16, indent: 24, endIndent: 24, color: context.colors.divider),
          ProfileMenuItem(
            label: AppStrings.settings,
            icon: Icons.settings_outlined,
            onTap: () {
              context.goNamed(BridegeXRouteNames.settings);
            },
          ),
          BridgeXDivider(height: 16, indent: 24, endIndent: 24, color: context.colors.divider),
          ProfileMenuItem(
            label: AppStrings.logout,
            icon: Icons.logout_outlined,
            onTap: () async {
              final confirmed = await LogoutDialog.show(context);
              if (confirmed ?? false) {
                // Handle logout logic
              }
            },
            isDestructive: true,
          ),
          VerticalSpacing(AppSpacing.sm),
        ],
      ),
    );
  }
}
