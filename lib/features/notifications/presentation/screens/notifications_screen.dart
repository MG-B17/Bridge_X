import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/text_style.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../../core/widgets/v_space.dart';
import '../widgets/notification_item_widget.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.notifications,
                    style: context.displayLarge.copyWith(
                      color: context.colors.primary,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      AppStrings.markAllRead,
                      style: context.bodyMedium.copyWith(
                        color: context.colors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VSpace(20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.recent,
                          style: context.labelSmall.copyWith(
                            color: context.colors.textSecondary,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: context.colors.primary,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            '2 ${AppStrings.newBadge}',
                            style: context.labelSmall.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    VSpace(12.h),
                    _buildNotificationCard([
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
                    ]),
                    VSpace(30.h),
                    Text(
                      AppStrings.earlier,
                      style: context.labelSmall.copyWith(
                        color: context.colors.textSecondary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    VSpace(12.h),
                    _buildNotificationCard([
                      const NotificationItemWidget(
                        category: 'Alpha Coders',
                        title: 'New Message',
                        message: AppStrings.newMessageInAlphaCoders,
                        time: 'Yesterday',
                        icon: Icons.chat_bubble_outline_rounded,
                        iconBgColor: Color(0xFFF3F4F6),
                        iconColor: Color(0xFF9CA3AF),
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
                    ]),
                    VSpace(30.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) context.go(AppRouteConstant.matching);
          if (index == 1) context.go(AppRouteConstant.chat);
          if (index == 2) context.go(AppRouteConstant.teams);
          if (index == 3) context.go(AppRouteConstant.profile);
        },
      ),
    );
  }

  Widget _buildNotificationCard(List<Widget> children) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1.w),
      ),
      child: Column(
        children: children,
      ),
    );
  }
}
