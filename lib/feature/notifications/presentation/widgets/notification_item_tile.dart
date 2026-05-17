import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/navigation/screens_args/notifications_details_args.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:bridge_x/feature/notifications/presentation/widgets/notification_icon_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class NotificationItemTile extends StatelessWidget {
  final int index;
  const NotificationItemTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    String title;
    String subtitle;
    IconData icon;
    Color iconBg;
    Color iconColor;
    String time;

    switch (index) {
      case 0:
        title = AppStrings.youreIn;
        subtitle = AppStrings.acceptedIntoFrontendGuild;
        icon = Icons.party_mode_outlined;
        iconBg = context.colors.success.withValues(alpha: 0.1);
        iconColor = context.colors.success;
        time = AppStrings.justNow;
        break;
      case 1:
        title = AppStrings.newTaskAssigned;
        subtitle = AppStrings.assignedNewTask;
        icon = Icons.assignment_outlined;
        iconBg = context.colors.amber.withValues(alpha: 0.1);
        iconColor = context.colors.amber;
        time = AppStrings.twoHoursAgo;
        break;
      case 2:
        title = AppStrings.requestUpdate;
        subtitle = AppStrings.taskStatusUpdated;
        icon = Icons.update_outlined;
        iconBg = context.colors.primaryLight.withValues(alpha: 0.5);
        iconColor = context.colors.primary;
        time = AppStrings.today;
        break;
      default:
        title = AppStrings.requestToJoinNotApproved;
        subtitle = AppStrings.tryAgain;
        icon = Icons.cancel_outlined;
        iconBg = context.colors.error.withValues(alpha: 0.1);
        iconColor = context.colors.error;
        time = AppStrings.today;
    }

    return InkWell(
      onTap: () {
        final NotificationsDetailsArgs args = NotificationsDetailsArgs(
          title: title,
          subtitle: subtitle,
          icon: icon,
          iconBg: iconBg,
          iconColor: iconColor,
          time: time,
        );
        context.pushNamed(BridegeXRouteNames.notificationsDetails, extra: args);
      },
      borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
      child: Container(
        padding: AppSpacing.pagePadding,
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
          border: Border.all(color: context.colors.divider),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotificationIconContainer(icon: icon, iconBg: iconBg, iconColor: iconColor),
            HorizontalSpacing(AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.colors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  VerticalSpacing(AppSpacing.xs),
                  Text(
                    subtitle,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colors.textSecondary,
                      fontSize: 14.sp,
                    ),
                  ),
                  VerticalSpacing(AppSpacing.sm),
                  Text(
                    time,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: context.colors.textHint,
                      fontSize: 12.sp,
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
}
