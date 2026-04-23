import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/text_style.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/bridge_app_button.dart';
import '../../../../core/widgets/bridge_dialogs.dart';
import '../../../../core/widgets/v_space.dart';
import '../widgets/role_tag_widget.dart';
import '../widgets/selection_pill_widget.dart';
import '../widgets/team_type_card_widget.dart';

class CreateTeamScreen extends StatefulWidget {
  const CreateTeamScreen({super.key});

  @override
  State<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  bool isPrivate = true;
  String selectedCategory = AppStrings.development;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: context.colors.primary, size: 20.sp),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VSpace(10.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFDBEAFE),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.stars_rounded, color: context.colors.primary, size: 20.sp),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      AppStrings.youAreTeamLeader,
                      style: context.labelSmall.copyWith(
                        color: context.colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            VSpace(30.h),
            Text(
              AppStrings.teamType,
              style: context.bodyLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colors.textPrimary,
              ),
            ),
            VSpace(16.h),
            TeamTypeCardWidget(
              title: AppStrings.private,
              description: AppStrings.privateDesc,
              icon: Icons.lock_rounded,
              isSelected: isPrivate,
              onTap: () => setState(() => isPrivate = true),
            ),
            TeamTypeCardWidget(
              title: AppStrings.public,
              description: AppStrings.publicDesc,
              icon: Icons.public_rounded,
              isSelected: !isPrivate,
              onTap: () => setState(() => isPrivate = false),
            ),
            VSpace(24.h),
            _buildLabel(AppStrings.teamName),
            VSpace(8.h),
            const AppTextField(hintText: 'e.g. Project Phoenix'),
            VSpace(24.h),
            _buildLabel(AppStrings.githubUrl),
            VSpace(8.h),
            const AppTextField(hintText: 'URL'),
            VSpace(24.h),
            _buildLabel(AppStrings.projectDescription),
            VSpace(8.h),
            const AppTextField(
              hintText: AppStrings.describeProjectHint,
              maxLines: 4,
            ),
            VSpace(24.h),
            _buildLabel(AppStrings.categorySelection),
            VSpace(12.h),
            Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: [
                SelectionPillWidget(
                  label: AppStrings.development,
                  isSelected: selectedCategory == AppStrings.development,
                  onTap: () => setState(() => selectedCategory = AppStrings.development),
                ),
                SelectionPillWidget(
                  label: AppStrings.design,
                  isSelected: selectedCategory == AppStrings.design,
                  onTap: () => setState(() => selectedCategory = AppStrings.design),
                ),
                SelectionPillWidget(
                  label: AppStrings.marketing,
                  isSelected: selectedCategory == AppStrings.marketing,
                  onTap: () => setState(() => selectedCategory = AppStrings.marketing),
                ),
                SelectionPillWidget(
                  label: AppStrings.research,
                  isSelected: selectedCategory == AppStrings.research,
                  onTap: () => setState(() => selectedCategory = AppStrings.research),
                ),
              ],
            ),
            VSpace(30.h),
            _buildLabel(AppStrings.requiredRoles),
            VSpace(12.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: context.colors.divider, width: 1.w),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: [
                      RoleTagWidget(label: 'Frontend', onRemove: () {}),
                      RoleTagWidget(label: 'UX Designer', onRemove: () {}),
                    ],
                  ),
                  VSpace(12.h),
                  Text(
                    AppStrings.addMoreHint,
                    style: context.labelSmall.copyWith(
                      color: context.colors.textHint,
                    ),
                  ),
                ],
              ),
            ),
            VSpace(8.h),
            Text(
              AppStrings.rolesUsageDisclaimer,
              style: context.labelSmall.copyWith(
                color: context.colors.textSecondary.withOpacity(0.8),
                fontSize: 10.sp,
              ),
            ),
            VSpace(30.h),
            _buildLabel('Team Members'),
            Text(
              'Invite members manually',
              style: context.labelSmall.copyWith(
                color: context.colors.textSecondary,
                fontSize: 12.sp,
              ),
            ),
            VSpace(12.h),
            AppButton(
              label: AppStrings.addMember,
              isSecondary: true,
              onPressed: () {},
              leading: Icon(Icons.person_add_outlined, color: context.colors.primary, size: 20.sp),
            ),
            VSpace(40.h),
            AppButton(
              label: AppStrings.createTeam,
              onPressed: () => BridgeDialogs.showTeamCreated(context),
              trailing: Icon(Icons.rocket_launch_outlined, color: Colors.white, size: 20.sp),
            ),
            VSpace(40.h),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) context.go(AppRouteConstant.matching);
          if (index == 1) context.go(AppRouteConstant.chat);
          if (index == 2) context.go(AppRouteConstant.teams);
          if (index == 3) context.go(AppRouteConstant.profile);
        },
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: context.bodyMedium.copyWith(
        fontWeight: FontWeight.bold,
        color: context.colors.textPrimary,
      ),
    );
  }
}
