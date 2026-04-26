import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/h_space.dart';
import '../../../../core/widgets/v_space.dart';
import 'notification_item_widget.dart';

class NotificationsHeader extends StatelessWidget {
  const NotificationsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VSpace(context.spacing.xl),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppStrings.notifications, style: context.displayLarge.copyWith(fontWeight: FontWeight.w900)),
            _buildSettingsButton(context),
          ],
        ),
      ],
    );
  }

  Widget _buildSettingsButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: context.colors.divider)),
      child: Icon(Icons.settings_outlined, color: context.colors.textSecondary, size: 20.w),
    );
  }
}

class NotificationSectionHeader extends StatelessWidget {
  final String title;
  final String? badge;

  const NotificationSectionHeader({super.key, required this.title, this.badge});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title.toUpperCase(), style: context.labelSmall.copyWith(color: context.colors.textSecondary, fontWeight: FontWeight.w900, letterSpacing: 1.2)),
        if (badge != null) ...[
          HSpace(context.spacing.sm),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(color: context.colors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20.r)),
            child: Text(badge!, style: context.labelSmall.copyWith(color: context.colors.primary, fontWeight: FontWeight.w900, fontSize: 10.sp)),
          ),
        ],
      ],
    );
  }
}

class NotificationCard extends StatelessWidget {
  final List<Widget> children;
  const NotificationCard({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge), border: Border.all(color: context.colors.divider)),
      child: Column(children: children),
    );
  }
}

class RecentNotificationsList extends StatelessWidget {
  const RecentNotificationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return NotificationCard(
      children: [
        NotificationItemWidget(
          category: 'Frontend Guild',
          title: AppStrings.youreIn,
          message: AppStrings.acceptedIntoFrontendGuild,
          time: '2h ago',
          icon: Icons.check_rounded,
          iconBgColor: const Color(0xFFDBEAFE),
          iconColor: context.colors.primary,
          isNew: true,
        ),
        NotificationItemWidget(
          category: 'Assignment',
          title: AppStrings.newTaskAssigned,
          message: AppStrings.assignedNewTask,
          time: '4h ago',
          icon: Icons.assignment_outlined,
          iconBgColor: const Color(0xFFDBEAFE),
          iconColor: context.colors.primary,
          isNew: true,
          showDivider: false,
        ),
      ],
    );
  }
}

class EarlierNotificationsList extends StatelessWidget {
  const EarlierNotificationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return NotificationCard(
      children: [
        NotificationItemWidget(
          category: 'Alpha Coders',
          title: 'New Message',
          message: AppStrings.newMessageInAlphaCoders,
          time: 'Yesterday',
          icon: Icons.chat_bubble_outline_rounded,
          iconBgColor: const Color(0xFFF3F4F6),
          iconColor: const Color(0xFF9CA3AF),
        ),
        NotificationItemWidget(
          category: 'Updates',
          title: AppStrings.taskUpdated,
          message: AppStrings.taskStatusUpdated,
          time: '2 days ago',
          icon: Icons.update_rounded,
          iconBgColor: const Color(0xFFF3F4F6),
          iconColor: const Color(0xFF9CA3AF),
        ),
        NotificationItemWidget(
          category: 'Access Denied',
          title: AppStrings.requestUpdate,
          message: AppStrings.requestToJoinNotApproved,
          time: '3 days ago',
          icon: Icons.error_outline_rounded,
          iconBgColor: const Color(0xFFFEE2E2),
          iconColor: const Color(0xFFEF4444),
          showDivider: false,
        ),
      ],
    );
  }
}
