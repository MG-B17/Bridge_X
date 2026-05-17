import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';

import 'package:bridge_x/core/widget/bridge_x_screen_header.dart';
import 'package:bridge_x/core/widget/bridge_x_background_gears.dart';
import 'package:go_router/go_router.dart';
import '../widget/settings_menu_item.dart';
import '../widget/settings_version_text.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BridgeXBackgroundGears(),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BridgeXScreenHeader(title: AppStrings.settings),
                  VerticalSpacing(AppSpacing.xxl),
                  SettingsMenuItem(
                    label: AppStrings.notifications,
                    icon: Icons.notifications_none,
                    onTap: () {
                      context.goNamed(BridegeXRouteNames.notificationsSettings);
                    },
                  ),
                  VerticalSpacing(AppSpacing.sm),
                  SettingsMenuItem(
                    label: AppStrings.privacyAndSecurity,
                    icon: Icons.lock_outline,
                    onTap: () {
                      context.goNamed(BridegeXRouteNames.privacySecurity);
                    },
                  ),
                  VerticalSpacing(AppSpacing.sm),
                  SettingsMenuItem(
                    label: AppStrings.aboutUs,
                    icon: Icons.info_outline,
                    onTap: () {
                      context.goNamed(BridegeXRouteNames.aboutUs);
                    },
                  ),
                  VerticalSpacing(AppSpacing.xxl),
                  const SettingsVersionText(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
