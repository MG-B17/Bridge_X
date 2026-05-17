import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:bridge_x/feature/notifications/presentation/widgets/notification_icon_container.dart';
import 'package:flutter/material.dart';

class NotificationDetailsHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String time;

  const NotificationDetailsHeader({
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
    return Column(
      children: [
        NotificationIconContainer(
          icon: icon,
          iconBg: iconBg,
          iconColor: iconColor,
          iconSize: 48,
          padding: AppSpacing.xl,
        ),
        VerticalSpacing(AppSpacing.xxl),
        Text(
          title,
          style: context.textTheme.headlineSmall?.copyWith(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        VerticalSpacing(AppSpacing.md),
        Text(
          subtitle,
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colors.textSecondary,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        VerticalSpacing(AppSpacing.md),
        Text(
          time,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colors.textHint,
          ),
        ),
      ],
    );
  }
}
