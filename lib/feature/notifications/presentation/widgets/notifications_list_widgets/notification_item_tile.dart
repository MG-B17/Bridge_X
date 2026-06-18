import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_names.dart';
import 'package:bridge_x/core/navigation/screens_args/notifications_details_args.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/notifications/domain/entities/notification_entity.dart';
import 'package:bridge_x/feature/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:bridge_x/feature/notifications/presentation/widgets/notifications_list_widgets/notification_icon_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NotificationItemTile extends StatelessWidget {
  final NotificationEntity notification;

  const NotificationItemTile({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final title = _title;
    final subtitle = notification.message.isNotEmpty
        ? notification.message
        : notification.type;
    final time = _formatTime(notification.createdAt);
    final visuals = _visuals(context);

    return InkWell(
      onTap: () async {
        if (!notification.isRead) {
          final isMarked = await context.read<NotificationsCubit>().markAsRead(
            notification.id,
          );
          if (!context.mounted || !isMarked) return;
        }

        final NotificationsDetailsArgs args = NotificationsDetailsArgs(
          title: title,
          subtitle: subtitle,
          icon: visuals.icon,
          iconBg: visuals.iconBg,
          iconColor: visuals.iconColor,
          time: time,
        );
        context.pushNamed(BridgeXRouteNames.notificationsDetails, extra: args);
      },
      borderRadius: BorderRadius.circular(AppSpacing.radius16),
      child: Container(
        padding: AppSpacing.pagePadding,
        decoration: BoxDecoration(
          color: notification.isRead
              ? context.colors.surface.withValues(alpha: .6)
              : context.colors.teal.withValues(alpha: .1),
          borderRadius: BorderRadius.circular(AppSpacing.radius16),
          border: Border(
            left: BorderSide(
              color: notification.isRead
                  ? context.colors.textSecondary
                  : visuals.iconColor,
              width: AppSpacing.width6,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotificationIconContainer(
              icon: visuals.icon,
              iconBg: visuals.iconBg,
              iconColor: visuals.iconColor,
            ),
            HorizontalSpacing(AppSpacing.spacing16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.colors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: AppSpacing.fontSize16,
                    ),
                  ),
                  VerticalSpacing(AppSpacing.spacing4),
                  Text(
                    subtitle,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colors.textPrimary,
                      fontSize: AppSpacing.fontSize14,
                    ),
                  ),
                  VerticalSpacing(AppSpacing.spacing8),
                  Text(
                    time,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: context.colors.textSecondary,
                      fontSize: AppSpacing.fontSize12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String get _title {
    final teamName = notification.notificationData.teamName;
    if (teamName != null && teamName.isNotEmpty) return teamName;
    if (notification.type.isEmpty) return AppStrings.notifications;

    return notification.type
        .replaceAll('_', ' ')
        .split(' ')
        .where((word) => word.isNotEmpty)
        .map((word) => '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
  }

  ({IconData icon, Color iconBg, Color iconColor}) _visuals(
    BuildContext context,
  ) {
    final type = notification.type.toLowerCase();
    if (type.contains('task')) {
      return (
        icon: Icons.assignment_outlined,
        iconBg: context.colors.amber.withValues(alpha: 0.1),
        iconColor: context.colors.teal,
      );
    }
    if (type.contains('update')) {
      return (
        icon: Icons.update_outlined,
        iconBg: context.colors.primaryLight.withValues(alpha: 0.5),
        iconColor: context.colors.error,
      );
    }
    if (type.contains('reject') ||
        type.contains('cancel') ||
        type.contains('denied')) {
      return (
        icon: Icons.cancel_outlined,
        iconBg: context.colors.error.withValues(alpha: 0.1),
        iconColor: context.colors.textSecondary,
      );
    }
    if (type.contains('accept') || type.contains('join')) {
      return (
        icon: Icons.party_mode_outlined,
        iconBg: context.colors.success.withValues(alpha: 0.1),
        iconColor: context.colors.teal,
      );
    }

    return (
      icon: Icons.notifications_outlined,
      iconBg: context.colors.primaryLight.withValues(alpha: 0.5),
      iconColor: context.colors.primary,
    );
  }

  String _formatTime(String? createdAt) {
    if (createdAt == null || createdAt.isEmpty) return AppStrings.today;

    final dateTime = DateTime.tryParse(createdAt)?.toLocal();
    if (dateTime == null) return createdAt;

    final difference = DateTime.now().difference(dateTime);
    if (difference.inMinutes < 1) return AppStrings.justNow;
    if (difference.inHours < 1) return '${difference.inMinutes}m ago';
    if (difference.inHours < 24) return '${difference.inHours}h ago';
    if (difference.inDays == 1) return AppStrings.today;
    return '${difference.inDays}d ago';
  }
}
