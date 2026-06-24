import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/bridge_x_background_gears.dart';
import 'package:bridge_x/core/widget/layout/bridge_x_divider.dart';
import 'package:bridge_x/core/widget/layout/bridge_x_screen_header.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/settings/presentation/controller/notification_settings_cubit.dart';
import 'package:bridge_x/features/settings/presentation/controller/notification_settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/notification_settings_screen_widget/notification_setting_item.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationSettingsCubit>(
      create: (_) => sl<NotificationSettingsCubit>(),
      child: Scaffold(
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
                      child: BlocBuilder<NotificationSettingsCubit, NotificationSettingsState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              NotificationSettingItem(
                                title: AppStrings.pushNotifications,
                                subtitle: AppStrings.pushNotificationsDesc,
                                icon: Icons.notifications_none,
                                value: state.pushNotificationsEnabled,
                                onChanged: (val) {
                                  context
                                      .read<NotificationSettingsCubit>()
                                      .togglePushNotifications(val);
                                },
                              ),
                              const BridgeXDivider(height: 1, thickness: 1),
                              NotificationSettingItem(
                                title: AppStrings.teamUpdates,
                                subtitle: AppStrings.teamUpdatesDesc,
                                icon: Icons.people_outline,
                                value: state.teamUpdatesEnabled,
                                onChanged: (val) {
                                  context
                                      .read<NotificationSettingsCubit>()
                                      .setTeamUpdatesEnabled(val);
                                },
                              ),
                              const BridgeXDivider(height: 1, thickness: 1),
                              NotificationSettingItem(
                                title: AppStrings.newMessages,
                                subtitle: AppStrings.newMessagesDesc,
                                icon: Icons.chat_bubble_outline,
                                iconBgColor:
                                    context.colors.warning.withValues(alpha: 0.15),
                                iconColor: context.colors.warning,
                                value: state.newMessagesEnabled,
                                onChanged: (val) {
                                  context
                                      .read<NotificationSettingsCubit>()
                                      .setNewMessagesEnabled(val);
                                },
                              ),
                              const BridgeXDivider(height: 1, thickness: 1),
                              NotificationSettingItem(
                                title: AppStrings.taskUpdates,
                                subtitle: AppStrings.taskUpdatesDesc,
                                icon: Icons.assignment_turned_in_outlined,
                                value: state.taskUpdatesEnabled,
                                onChanged: (val) {
                                  context
                                      .read<NotificationSettingsCubit>()
                                      .setTaskUpdatesEnabled(val);
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
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
