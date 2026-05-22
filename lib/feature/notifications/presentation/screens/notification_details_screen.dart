import 'package:bridge_x/core/animation/bottom_nav_bar_animation/widget/scroller_listener.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_back_button.dart';
import 'package:bridge_x/core/widget/layout/bridge_x_background_gears.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import '../widgets/notification_details_widget/notification_details_actions.dart';
import '../widgets/notification_details_widget/notification_details_header.dart';
import 'package:flutter/material.dart';

class NotificationDetailsScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String time;

  const NotificationDetailsScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.time,
  });

  @override
  State<NotificationDetailsScreen> createState() => _NotificationDetailsScreenState();
}

class _NotificationDetailsScreenState extends State<NotificationDetailsScreen> {
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
        ),
        body: Stack(
          children: [
            const BridgeXBackgroundGears(icon: Icons.notifications,),
            SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.only(
                left: AppSpacing.spacing16,
                right: AppSpacing.spacing16,
                top: AppSpacing.spacing16,
                bottom: AppSpacing.spacing16 + AppSpacing.spacing20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  VerticalSpacing(AppSpacing.spacing24),
                  NotificationDetailsHeader(
                    title: widget.title,
                    subtitle: widget.subtitle,
                    icon: widget.icon,
                    iconBg: widget.iconBg,
                    iconColor: widget.iconColor,
                    time: widget.time,
                  ),
                  VerticalSpacing(AppSpacing.spacing48),
                  const NotificationDetailsActions(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
