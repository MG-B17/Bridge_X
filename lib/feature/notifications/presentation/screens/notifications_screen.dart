import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/bridge_x_back_button.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:bridge_x/feature/notifications/presentation/widgets/notification_item_tile.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: context.colors.scaffoldBg,
        elevation: 0,
        leading: Center(
          child: const BridgeXBackButton(),
        ),
        title: Text(
          AppStrings.notifications,
          style: context.textTheme.titleLarge?.copyWith(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              AppStrings.markAllRead,
              style: context.textTheme.labelLarge?.copyWith(
                color: context.colors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        padding: AppSpacing.pagePadding,
        itemCount: 4,
        separatorBuilder: (context, index) => VerticalSpacing(AppSpacing.md),
        itemBuilder: (context, index) {
          return NotificationItemTile(index: index);
        },
      ),
    );
  }
}
