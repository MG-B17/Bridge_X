import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/text_style.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../../core/widgets/bridge_app_button.dart';
import '../../../../core/widgets/v_space.dart';
import '../widgets/member_avatar_widget.dart';
import '../widgets/role_card_widget.dart';
import '../widgets/task_item_widget.dart';

class WorkspaceScreen extends StatelessWidget {
  const WorkspaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VSpace(context.spacing.md),
                    // Success Banner
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDBEAFE),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: context.colors.primary.withOpacity(0.1), width: 1.w),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: context.colors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.check, color: Colors.white, size: 16.sp),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.joinedTeam,
                                  style: context.bodyMedium.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: context.colors.primary,
                                  ),
                                ),
                                Text(
                                  AppStrings.startCollaboration,
                                  style: context.labelSmall.copyWith(
                                    color: context.colors.primary.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    VSpace(context.spacing.xl),
                    const RoleCardWidget(
                      label: AppStrings.yourRole,
                      role: AppStrings.uiuxDesigner,
                      description: AppStrings.roleDescription,
                    ),
                    VSpace(30.h),
                    Text(
                      AppStrings.overview,
                      style: context.labelSmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colors.textPrimary,
                        letterSpacing: 1.2,
                      ),
                    ),
                    VSpace(12.h),
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Text(
                        AppStrings.projectOverview,
                        style: context.bodyMedium.copyWith(
                          color: context.colors.textPrimary.withOpacity(0.8),
                          height: 1.5,
                        ),
                      ),
                    ),
                    VSpace(30.h),
                    Text(
                      AppStrings.members,
                      style: context.labelSmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colors.textPrimary,
                        letterSpacing: 1.2,
                      ),
                    ),
                    VSpace(16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        MemberAvatarWidget(
                          name: 'Sarah J.',
                          role: 'Lead Dev',
                          imageUrl: 'https://i.pravatar.cc/150?u=sarah',
                          isOnline: true,
                        ),
                        MemberAvatarWidget(
                          name: 'Marcus T.',
                          role: 'Fullstack',
                          imageUrl: 'https://i.pravatar.cc/150?u=marcus',
                          isOnline: true,
                        ),
                        MemberAvatarWidget(
                          name: 'Elena R.',
                          role: 'PM',
                          imageUrl: 'https://i.pravatar.cc/150?u=elena',
                        ),
                      ],
                    ),
                    VSpace(30.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.yourTasks,
                          style: context.labelSmall.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colors.textPrimary,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            AppStrings.viewAllTasks,
                            style: context.labelSmall.copyWith(
                              color: context.colors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    VSpace(16.h),
                    const TaskItemWidget(
                      title: 'Design Login Screen',
                      dueDate: AppStrings.dueTomorrow,
                      icon: Icons.edit_note_rounded,
                      iconColor: Color(0xFF3B82F6),
                      iconBgColor: Color(0xFFEFF6FF),
                    ),
                    const TaskItemWidget(
                      title: 'Refine Typography',
                      dueDate: AppStrings.nextSprint,
                      icon: Icons.format_paint_rounded,
                      iconColor: Color(0xFF9CA3AF),
                      iconBgColor: Color(0xFFF3F4F6),
                    ),
                    VSpace(30.h),
                    AppButton(
                      label: AppStrings.openTeamChat,
                      onPressed: () => context.push(AppRouteConstant.chat),
                      leading: Icon(Icons.chat_bubble_outline_rounded, color: Colors.white, size: 20.sp),
                    ),
                    VSpace(context.spacing.md),
                    AppButton(
                      label: AppStrings.viewProjectDetails,
                      onPressed: () {},
                      isSecondary: true,
                      leading: Icon(Icons.info_outline_rounded, color: context.colors.primary, size: 20.sp),
                    ),
                    VSpace(context.spacing.xl),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) context.go(AppRouteConstant.matching);
          if (index == 1) context.go(AppRouteConstant.chat);
          if (index == 2) context.go(AppRouteConstant.workspace);
          if (index == 3) context.go(AppRouteConstant.profile);
        },
      ),
    );
  }
}
