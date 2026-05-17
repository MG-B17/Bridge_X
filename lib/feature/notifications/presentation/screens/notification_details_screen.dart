import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/bridge_x_back_button.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:bridge_x/feature/notifications/presentation/widgets/notification_details_actions.dart';
import 'package:bridge_x/feature/notifications/presentation/widgets/notification_details_header.dart';
import 'package:flutter/material.dart';

class NotificationDetailsScreen extends StatelessWidget {
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
          AppStrings.details,
          style: context.textTheme.titleLarge?.copyWith(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            VerticalSpacing(AppSpacing.xl),
            NotificationDetailsHeader(
              title: title,
              subtitle: subtitle,
              icon: icon,
              iconBg: iconBg,
              iconColor: iconColor,
              time: time,
            ),
            VerticalSpacing(AppSpacing.xxl + AppSpacing.md),
            const NotificationDetailsActions(),
          ],
        ),
      ),
    );
  }
}
