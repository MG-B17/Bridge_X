import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/navigation/app_route_constant.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/bridge_app_button.dart';
import '../../../../core/widgets/v_space.dart';
import '../widgets/role_card_widget.dart';
import '../widgets/workspace_details.dart';

class WorkspaceScreen extends StatelessWidget {
  const WorkspaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VSpace(context.spacing.md),
              const WorkspaceBanner(),
              VSpace(context.spacing.xl),
              const RoleCardWidget(
                label: AppStrings.yourRole,
                role: AppStrings.uiuxDesigner,
                description: AppStrings.roleDescription,
              ),
              VSpace(context.spacing.xxl),
              _buildSectionHeader(context, AppStrings.overview),
              VSpace(context.spacing.md),
              _buildOverviewCard(context),
              VSpace(context.spacing.xxl),
              const WorkspaceMembers(),
              VSpace(context.spacing.xxl),
              const WorkspaceTasks(),
              VSpace(context.spacing.xxl),
              _buildActions(context),
              VSpace(context.spacing.xxl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String text) {
    return Text(
      text.toUpperCase(),
      style: context.labelSmall.copyWith(
        fontWeight: FontWeight.w900,
        color: context.colors.textPrimary,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildOverviewCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.spacing.lg),
      decoration: BoxDecoration(
        color: context.colors.divider.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(context.spacing.radiusCard),
      ),
      child: Text(
        AppStrings.projectOverview,
        style: context.bodyMedium.copyWith(
          color: context.colors.textPrimary.withValues(alpha: 0.8),
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Column(
      children: [
        AppButton(
          label: AppStrings.openTeamChat,
          onPressed: () => context.push(AppRouteConstant.chat),
          leading: Icon(
            Icons.chat_bubble_outline_rounded,
            color: Colors.white,
            size: 20.w,
          ),
        ),
        VSpace(context.spacing.md),
        AppButton(
          label: AppStrings.viewProjectDetails,
          onPressed: () {},
          isSecondary: true,
          leading: Icon(
            Icons.info_outline_rounded,
            color: context.colors.primary,
            size: 20.w,
          ),
        ),
      ],
    );
  }
}
