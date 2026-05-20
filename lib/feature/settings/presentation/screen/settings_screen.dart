import 'package:bridge_x/core/animation/bottom_nav_bar_animation/widget/scroller_listener.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';

import 'package:bridge_x/core/widget/bridge_x_screen_header.dart';
import 'package:bridge_x/core/widget/bridge_x_background_gears.dart';
import 'package:go_router/go_router.dart';
import '../widget/settings_widget/settings_menu_item.dart';
import '../widget/settings_widget/settings_version_text.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollNavListener(
      controller: _scrollController,
      child: Scaffold(
        body: Stack(
          children: [
            const BridgeXBackgroundGears(),
            SafeArea(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.only(
                  left: AppSpacing.spacing16,
                  right: AppSpacing.spacing16,
                  top: AppSpacing.spacing16,
                  bottom: AppSpacing.spacing16 + AppSpacing.spacing20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BridgeXScreenHeader(title: AppStrings.settings),
                    VerticalSpacing(AppSpacing.spacing32),
                    SettingsMenuItem(
                      label: AppStrings.notifications,
                      icon: Icons.notifications_none,
                      onTap: () {
                        context.goNamed(BridegeXRouteNames.notificationsSettings);
                      },
                    ),
                    VerticalSpacing(AppSpacing.spacing8),
                    SettingsMenuItem(
                      label: AppStrings.privacyAndSecurity,
                      icon: Icons.lock_outline,
                      onTap: () {
                        context.goNamed(BridegeXRouteNames.privacySecurity);
                      },
                    ),
                    VerticalSpacing(AppSpacing.spacing8),
                    SettingsMenuItem(
                      label: AppStrings.aboutUs,
                      icon: Icons.info_outline,
                      onTap: () {
                        context.goNamed(BridegeXRouteNames.aboutUs);
                      },
                    ),
                    VerticalSpacing(AppSpacing.spacing32),
                    const SettingsVersionText(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
