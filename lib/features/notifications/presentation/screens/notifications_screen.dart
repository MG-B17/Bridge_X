import 'package:flutter/material.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';
import '../widgets/notifications_details.dart';

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
              padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
              child: const NotificationsHeader(),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VSpace(context.spacing.md),
                    const NotificationSectionHeader(title: AppStrings.recent, badge: '2 New'),
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
