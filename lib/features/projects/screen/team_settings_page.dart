import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/navigation/app_route_constant.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';
import '../../../../core/widgets/h_space.dart';
import '../../../../core/widgets/bridge_app_button.dart';
import '../../../../core/widgets/bridge_dialogs.dart';

class TeamSettingsPage extends StatelessWidget {
  const TeamSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(context.spacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(context),
              VSpace(context.spacing.lg),
              _buildSectionHeader(context, 'TEAM INFO'),
              VSpace(context.spacing.sm),
              _buildTeamInfoCard(context),
              VSpace(context.spacing.xl),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSectionHeader(context, 'MEMBERS MANAGEMENT'),
                  _buildCountBadge(context, '4 MEMBERS'),
                ],
              ),
              VSpace(context.spacing.sm),
              _buildMembersList(context),
              VSpace(context.spacing.md),
              _buildAddMemberButton(context),
              VSpace(context.spacing.xl),
              _buildSectionHeader(context, 'ASSIGN TASKS'),
              VSpace(context.spacing.md),
              AppButton(
                label: 'Create / Assign Task',
                leading: Icon(Icons.assignment_turned_in_outlined, color: Colors.white, size: 24.r),
                onPressed: () => context.push(AppRouteConstant.myTasksScreen),
              ),
              VSpace(context.spacing.xl),
              _buildSectionHeader(context, 'PROJECT CONTROL'),
              VSpace(context.spacing.xxl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: context.colors.primary, size: 28.r),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        VSpace(context.spacing.lg),
        Text(
          'Team Settings',
          style: context.headlineSmall.copyWith(
            fontWeight: FontWeight.w900,
            color: const Color(0xFF0D47A1),
          ),
        ),
        Text(
          'Mentor Access',
          style: context.bodyMedium.copyWith(
            color: context.colors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: context.labelSmall.copyWith(
        color: context.colors.textSecondary,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildCountBadge(BuildContext context, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFDBEAFE),
        borderRadius: BorderRadius.circular(context.spacing.radiusPill),
      ),
      child: Text(
        text,
        style: context.labelSmall.copyWith(
          color: const Color(0xFF1E40AF),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTeamInfoCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.spacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
        border: Border.all(color: context.colors.textHint.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoField(context, 'TEAM NAME', 'Alpha Innovation Squad'),
          VSpace(context.spacing.lg),
          _buildInfoField(context, 'PROJECT DESCRIPTION', 
            'Developing a decentralized platform for collaborative research and peer mentoring in STEM fields.'),
        ],
      ),
    );
  }

  Widget _buildInfoField(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.labelSmall.copyWith(
            color: context.colors.textHint,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        VSpace(4.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(context.spacing.md),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            value,
            style: context.bodyMedium.copyWith(
              color: context.colors.textPrimary,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMembersList(BuildContext context) {
    return Column(
      children: [
        _buildMemberTile(context, 'Alex Smith', 'UI Designer', 'AS', Colors.blue.shade100, Colors.blue.shade800),
        VSpace(context.spacing.md),
        _buildMemberTile(context, 'Mike Ross', 'Researcher', 'MK', Colors.orange.shade100, Colors.orange.shade800),
        VSpace(context.spacing.md),
        _buildMemberTile(context, 'Jane Doe', 'Lead Developer', 'JD', Colors.indigo.shade100, Colors.indigo.shade800),
      ],
    );
  }

  Widget _buildMemberTile(BuildContext context, String name, String role, String initials, Color bgColor, Color textColor) {
    return Container(
      padding: EdgeInsets.all(context.spacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
        border: Border.all(color: context.colors.textHint.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24.r,
            backgroundColor: bgColor,
            child: Text(
              initials,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ),
          HSpace(context.spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: context.titleMedium.copyWith(
                    fontWeight: FontWeight.w900,
                    color: context.colors.textPrimary,
                  ),
                ),
                Text(
                  role,
                  style: context.labelSmall.copyWith(
                    color: context.colors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => BridgeDialogs.showReportUser(
              context,
              userName: name,
              userRole: role,
              userAvatar: '',
            ),
            icon: Icon(Icons.more_vert, color: context.colors.textHint, size: 24.r),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildAddMemberButton(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: context.spacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
        border: Border.all(
          color: context.colors.textHint.withValues(alpha: 0.2),
          style: BorderStyle.solid,
        ),
      ),
      child: Center(
        child: Text(
          'Add Member',
          style: context.bodyLarge.copyWith(
            color: context.colors.textHint,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
