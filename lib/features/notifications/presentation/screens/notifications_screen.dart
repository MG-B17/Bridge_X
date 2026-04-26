
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';
import '../widgets/notifications_details.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 10.h),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: context.colors.primary),
                    onPressed: () => context.pop(),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      AppStrings.notifications,
                      style: context.displayLarge.copyWith(
                        color: context.colors.primary,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w800,
                      ),
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
                padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VSpace(context.spacing.md),
                    const NotificationSectionHeader(
                      title: AppStrings.recent,
                      badge: '2 New',
                    ),
                    VSpace(context.spacing.md),
                    const RecentNotificationsList(),
                    VSpace(context.spacing.xxl),
                    const NotificationSectionHeader(title: AppStrings.earlier),
                    VSpace(context.spacing.md),
                    const EarlierNotificationsList(),
                    VSpace(context.spacing.xxl),
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
