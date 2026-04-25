import 'package:flutter/material.dart';
import '../utils/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constant/app_strings.dart';
import 'bridge_dialog.dart';
import 'package:go_router/go_router.dart';
import '../navigation/app_route_constant.dart';

class BridgeDialogs {
  static void showTeamCreated(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => BridgeDialog(
        icon: Icons.rocket_launch_rounded,
        iconColor: Colors.white,
        iconBgColor: context.colors.primary,
        title: AppStrings.teamCreatedSuccessfully,
        description: AppStrings.teamReadyStartCollaborating,
        primaryButtonLabel: AppStrings.goToTeam,
        onPrimaryPressed: () {
          Navigator.pop(context);
          context.push(AppRouteConstant.teams);
        },
        textLinkLabel: AppStrings.backToHome,
        onTextLinkPressed: () {
          Navigator.pop(context);
          context.go(AppRouteConstant.home);
        },
        extraContent: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6).withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Icon(Icons.auto_awesome_outlined, color: context.colors.primary, size: 16.sp),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.quickSetup,
                    style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.bold, color: context.colors.textHint),
                  ),
                  Text(
                    'Alpha Project Workspace',
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: context.colors.textPrimary),
                  ),
                ],
              ),
              const Spacer(),
              _buildSmallAvatars(),
            ],
          ),
        ),
      ),
    );
  }

  static void showYouAreIn(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => BridgeDialog(
        icon: Icons.check_circle_rounded,
        iconColor: Colors.white,
        iconBgColor: context.colors.primary,
        title: AppStrings.youreIn,
        description: 'You have successfully joined Global Strategy Group',
        primaryButtonLabel: AppStrings.viewTeam,
        onPrimaryPressed: () => Navigator.pop(context),
        secondaryButtonLabel: AppStrings.openChat,
        onSecondaryPressed: () => Navigator.pop(context),
      ),
    );
  }

  static void showReportSubmitted(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => BridgeDialog(
        icon: Icons.verified_user_rounded,
        iconColor: Colors.white,
        iconBgColor: context.colors.primary,
        title: AppStrings.reportSubmitted,
        description: AppStrings.reportSubmittedDesc,
        primaryButtonLabel: AppStrings.backToTeam,
        onPrimaryPressed: () => Navigator.pop(context),
      ),
    );
  }

  static void showConfirmReport(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => BridgeDialog(
        icon: Icons.error_outline_rounded,
        iconColor: const Color(0xFFEF4444),
        iconBgColor: const Color(0xFFFEE2E2),
        title: AppStrings.submitReportTitle,
        description: AppStrings.submitReportDesc,
        primaryButtonLabel: AppStrings.confirm,
        onPrimaryPressed: () => Navigator.pop(context),
        textLinkLabel: AppStrings.cancel,
        onTextLinkPressed: () => Navigator.pop(context),
      ),
    );
  }

  static void showLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => BridgeDialog(
        icon: Icons.logout_rounded,
        iconColor: context.colors.primary,
        iconBgColor: const Color(0xFFDBEAFE),
        title: AppStrings.logoutTitle,
        description: AppStrings.logoutConfirm,
        primaryButtonLabel: AppStrings.logout,
        onPrimaryPressed: () {
          Navigator.pop(context);
          context.go(AppRouteConstant.login);
        },
        textLinkLabel: AppStrings.cancel,
        onTextLinkPressed: () => Navigator.pop(context),
      ),
    );
  }

  static void showProjectCompleted(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => BridgeDialog(
        icon: Icons.emoji_events_rounded,
        iconColor: Colors.white,
        iconBgColor: context.colors.primary,
        title: AppStrings.projectCompleted,
        description: AppStrings.projectSuccessfullySubmitted,
        primaryButtonLabel: AppStrings.viewSummary,
        onPrimaryPressed: () => Navigator.pop(context),
        textLinkLabel: AppStrings.backToProjects,
        onTextLinkPressed: () => Navigator.pop(context),
        extraContent: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6).withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Icon(Icons.verified_outlined, color: context.colors.textHint, size: 20.sp),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'STATUS UPDATE',
                    style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.bold, color: context.colors.textHint),
                  ),
                  Text(
                    AppStrings.reviewPendingByAdmin,
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: context.colors.textPrimary),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildSmallAvatars() {
    return Stack(
      children: [
        _avatar(Colors.blue, 0),
        _avatar(Colors.orange, 12),
        _avatar(Colors.green, 24),
      ],
    );
  }

  static Widget _avatar(Color color, double offset) {
    return Padding(
      padding: EdgeInsets.only(left: offset.w),
      child: Container(
        width: 24.w,
        height: 24.w,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.2),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 1.5.w),
        ),
      ),
    );
  }
}
