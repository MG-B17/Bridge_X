import 'package:go_router/go_router.dart';
import '../../../../core/navigation/app_route_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/bridge_dialogs.dart';
import '../../../../core/widgets/v_space.dart';
import '../widgets/profile_menu_item_widget.dart';
import '../widgets/stat_card_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => context.push(AppRouteConstant.editProfile),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: context.colors.divider, width: 1.w),
                        ),
                        child: Row(
                          children: [
                            Text(
                              AppStrings.edit,
                              style: context.labelSmall.copyWith(
                                color: context.colors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Icon(Icons.edit_outlined, color: context.colors.primary, size: 14.sp),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              VSpace(20.h),
              Center(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: context.colors.textHint.withValues(alpha: 0.3), width: 1.w),
                      ),
                      child: CircleAvatar(
                        radius: 60.r,
                        backgroundColor: context.colors.secondary,
                        backgroundImage: const NetworkImage('https://i.pravatar.cc/300?u=ahmed'),
                      ),
                    ),
                    Positioned(
                      bottom: -10.h,
                      child: GestureDetector(
                        onTap: () => context.push(AppRouteConstant.level),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: context.colors.primary,
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(color: Colors.white, width: 2.w),
                            boxShadow: [
                              BoxShadow(
                                color: context.colors.primary.withValues(alpha: 0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                AppStrings.beginner,
                                style: context.labelSmall.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.sp,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Icon(Icons.military_tech_rounded, color: Colors.white, size: 14.sp),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              VSpace(30.h),
              Text(
                'Ahmed Ali',
                style: context.displayLarge.copyWith(
                  color: context.colors.textPrimary,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Beginner Frontend Developer',
                style: context.bodyMedium.copyWith(
                  color: context.colors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              VSpace(30.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    StatCardWidget(value: '12', label: AppStrings.completedTasksUpper),
                    StatCardWidget(value: '3', label: AppStrings.teamsUpper),
                    StatCardWidget(value: '10', label: AppStrings.activeTasksUpper),
                  ],
                ),
              ),
              VSpace(30.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(color: context.colors.divider, width: 1.w),
                  ),
                  child: Column(
                    children: [
                      ProfileMenuItemWidget(
                        title: AppStrings.myTasks,
                        icon: Icons.check_circle_outline_rounded,
                        iconBgColor: const Color(0xFFEFF6FF),
                        iconColor: const Color(0xFF3B82F6),
                        badgeCount: 3,
                        onTap: () => context.push(AppRouteConstant.myTasksScreen),
                      ),
                      ProfileMenuItemWidget(
                        title: AppStrings.myProjects,
                        icon: Icons.hub_outlined,
                        iconBgColor: const Color(0xFFEFF6FF),
                        iconColor: const Color(0xFF3B82F6),
                        onTap: () => context.push(AppRouteConstant.workspace),
                      ),
                      ProfileMenuItemWidget(
                        title: AppStrings.skillsAndExperience,
                        icon: Icons.psychology_outlined,
                        iconBgColor: const Color(0xFFEFF6FF),
                        iconColor: const Color(0xFF3B82F6),
                        onTap: () => context.push(AppRouteConstant.skillsExperience),
                      ),
                      ProfileMenuItemWidget(
                        title: AppStrings.settings,
                        icon: Icons.settings_outlined,
                        iconBgColor: const Color(0xFFF3F4F6),
                        iconColor: const Color(0xFF6B7280),
                        onTap: () => context.push(AppRouteConstant.privacySecurity),
                      ),
                      ProfileMenuItemWidget(
                        title: AppStrings.logout,
                        icon: Icons.logout_rounded,
                        iconBgColor: const Color(0xFFFEF2F2),
                        iconColor: const Color(0xFFEF4444),
                        isDestructive: true,
                        showDivider: false,
                        onTap: () => BridgeDialogs.showLogout(context),
                      ),
                    ],
                  ),
                ),
              ),
              VSpace(30.h),
            ],
          ),
        ),
      ),
    );
  }
}
