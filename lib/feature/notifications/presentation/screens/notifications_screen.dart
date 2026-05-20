import 'package:bridge_x/core/animation/bottom_nav_bar_animation/widget/scroller_listener.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/bridge_x_back_button.dart';
import 'package:bridge_x/core/widget/bridge_x_background_gears.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:bridge_x/feature/notifications/presentation/widgets/notifications_list_widgets/notification_item_tile.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
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
        appBar: AppBar(
          backgroundColor: context.colors.scaffoldBg,
          elevation: 0,
          leading: Center(
            child: const BridgeXBackButton(),
          ),
          title: Text(
            AppStrings.notifications,
            style: context.textTheme.titleLarge?.copyWith(
              color: context.colors.ongoingText,
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
        body: Stack(
          children: [
            const BridgeXBackgroundGears(icon: Icons.notifications,),
            ListView.separated(
              controller: _scrollController,
              padding: EdgeInsets.only(
                left: AppSpacing.spacing16,
                right: AppSpacing.spacing16,
                top: AppSpacing.spacing16,
                bottom: AppSpacing.spacing16 + AppSpacing.spacing20,
              ),
              itemCount: 4,
              separatorBuilder: (context, index) => VerticalSpacing(AppSpacing.spacing16),
              itemBuilder: (context, index) {
                return NotificationItemTile(index: index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
