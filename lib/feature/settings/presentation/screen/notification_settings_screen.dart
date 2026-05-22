import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/bridge_x_background_gears.dart';
import 'package:bridge_x/core/widget/layout/bridge_x_divider.dart';
import 'package:bridge_x/core/widget/layout/bridge_x_screen_header.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../widget/notification_settings_screen_widget/notification_setting_item.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool _pushNotificationsEnabled = true;
  bool _teamUpdatesEnabled = true;
  bool _newMessagesEnabled = false;
  bool _taskUpdatesEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.scaffoldBg,
      body: Stack(
        children: [
          const BridgeXBackgroundGears(),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.spacing16,
                vertical: AppSpacing.spacing16,
              ),
              child: Column(
                children: [
                  const BridgeXScreenHeader(
                    title: AppStrings.notifications,
                  ),
                  VerticalSpacing(AppSpacing.spacing24),
                  Container(
                    decoration: BoxDecoration(
                      color: context.colors.primary.withValues(alpha: 0.03),
                      borderRadius: BorderRadius.circular(AppSpacing.radius16),
                      border: Border.all(color: context.colors.divider),
                    ),
                    child: Column(
                      children: [
                        NotificationSettingItem(
                          title: AppStrings.pushNotifications,
                          subtitle: AppStrings.pushNotificationsDesc,
                          icon: Icons.notifications_none,
                          value: _pushNotificationsEnabled,
                          onChanged: (val) {
                            setState(() {
                              _pushNotificationsEnabled = val;
                            });
                          },
                        ),
                        const BridgeXDivider(height: 1, thickness: 1),
                        NotificationSettingItem(
                          title: AppStrings.teamUpdates,
                          subtitle: AppStrings.teamUpdatesDesc,
                          icon: Icons.people_outline,
                          value: _teamUpdatesEnabled,
                          onChanged: (val) {
                            setState(() {
                              _teamUpdatesEnabled = val;
                            });
                          },
                        ),
                        const BridgeXDivider(height: 1, thickness: 1),
                        NotificationSettingItem(
                          title: AppStrings.newMessages,
                          subtitle: AppStrings.newMessagesDesc,
                          icon: Icons.chat_bubble_outline,
                          iconBgColor: context.colors.warning.withValues(alpha: 0.15),
                          iconColor: context.colors.warning,
                          value: _newMessagesEnabled,
                          onChanged: (val) {
                            setState(() {
                              _newMessagesEnabled = val;
                            });
                          },
                        ),
                        const BridgeXDivider(height: 1, thickness: 1),
                        NotificationSettingItem(
                          title: AppStrings.taskUpdates,
                          subtitle: AppStrings.taskUpdatesDesc,
                          icon: Icons.assignment_turned_in_outlined,
                          value: _taskUpdatesEnabled,
                          onChanged: (val) {
                            setState(() {
                              _taskUpdatesEnabled = val;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
