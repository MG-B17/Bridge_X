import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/navigation/app_route_constant.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';
import '../../../../core/widgets/h_space.dart';
import '../../../../core/widgets/bridge_dialogs.dart';

class MentorProjectDetailsPage extends StatelessWidget {
  const MentorProjectDetailsPage({super.key});

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
              _buildBadges(context),
              VSpace(context.spacing.md),
              _buildProjectHeader(context),
              VSpace(context.spacing.xl),
              _buildStatsRow(context),
              VSpace(context.spacing.xl),
              _buildTeamMembersSection(context),
              VSpace(context.spacing.xl),
              _buildActionRow(context),
              VSpace(context.spacing.xl),
              _buildCompletionCard(context),
              VSpace(context.spacing.xxl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(Icons.arrow_back, color: context.colors.primary, size: 28.r),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }

  Widget _buildBadges(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: const Color(0xFF0D47A1),
            borderRadius: BorderRadius.circular(context.spacing.radiusPill),
          ),
          child: Text(
            'YOU ARE THE MENTOR',
            style: context.labelSmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
        ),
        HSpace(context.spacing.sm),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: const Color(0xFFC5CAE9),
            borderRadius: BorderRadius.circular(context.spacing.radiusPill),
          ),
          child: Text(
            'Ongoing',
            style: context.labelSmall.copyWith(
              color: const Color(0xFF303F9F),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quantum Dashboard Redesign',
          style: context.headlineSmall.copyWith(
            fontWeight: FontWeight.w900,
            color: context.colors.textPrimary,
          ),
        ),
        VSpace(context.spacing.md),
        Text(
          'Modernizing the core interface of our enterprise dashboard to improve user engagement and workflow efficiency for Q4 deployment.',
          style: context.bodyLarge.copyWith(
            color: context.colors.textSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            icon: Icons.assignment_outlined,
            value: '08',
            label: 'TASKS PENDING',
            iconColor: Colors.brown.shade700,
          ),
        ),
        HSpace(context.spacing.md),
        Expanded(
          child: _buildStatCard(
            context,
            icon: Icons.people_outline,
            value: '15',
            label: 'ACTIVE MEMBERS',
            iconColor: context.colors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
    required Color iconColor,
  }) {
    return Container(
      padding: EdgeInsets.all(context.spacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 24.r),
          VSpace(context.spacing.sm),
          Text(
            value,
            style: context.displayLarge.copyWith(
              fontWeight: FontWeight.w900,
              color: context.colors.textPrimary,
              height: 1.0,
            ),
          ),
          VSpace(context.spacing.xs),
          Text(
            label,
            style: context.labelSmall.copyWith(
              color: context.colors.primary,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMembersSection(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Team Members',
              style: context.titleLarge.copyWith(
                fontWeight: FontWeight.w900,
                color: context.colors.textPrimary,
              ),
            ),
            TextButton(
              onPressed: () => context.push(AppRouteConstant.teamSettings),
              child: Text(
                'Manage All',
                style: context.bodyMedium.copyWith(
                  color: const Color(0xFF0D47A1),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        VSpace(context.spacing.sm),
        Row(
          children: [
            Expanded(
              child: _buildMemberCard(
                context,
                name: 'Sarah Jenkins',
                role: 'Lead UI/UX',
                imageUrl: 'https://i.pravatar.cc/150?u=sarah',
                badgeText: '4 Tasks Done',
                isDone: true,
              ),
            ),
            HSpace(context.spacing.md),
            Expanded(
              child: _buildMemberCard(
                context,
                name: 'Marcus Knight',
                role: 'Frontend Engineer',
                imageUrl: 'https://i.pravatar.cc/150?u=marcus',
                badgeText: '2 Pending',
                isDone: false,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMemberCard(
    BuildContext context, {
    required String name,
    required String role,
    required String imageUrl,
    required String badgeText,
    required bool isDone,
  }) {
    return Container(
      padding: EdgeInsets.all(context.spacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
        border: Border.all(color: context.colors.textHint.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundImage: NetworkImage(imageUrl),
              ),
              IconButton(
                onPressed: () => BridgeDialogs.showReportUser(
                  context,
                  userName: name,
                  userRole: role,
                  userAvatar: imageUrl,
                ),
                icon: Icon(Icons.more_vert, color: context.colors.textHint, size: 20.r),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          VSpace(context.spacing.md),
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
          VSpace(context.spacing.md),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: context.colors.textHint.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isDone ? Icons.check_circle_outline : Icons.chat_bubble_outline,
                  size: 14.r,
                  color: context.colors.textPrimary,
                ),
                HSpace(4.w),
                Text(
                  badgeText,
                  style: context.labelSmall.copyWith(
                    color: context.colors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => context.go('${AppRouteConstant.chat}/${AppRouteConstant.chatRoom}'),
            child: _buildActionCard(
              context,
              icon: Icons.chat_bubble_outline,
              label: 'Open Chat',
            ),
          ),
        ),
        HSpace(context.spacing.md),
        Expanded(
          child: InkWell(
            onTap: () => context.push(AppRouteConstant.teamSettings),
            child: _buildActionCard(
              context,
              icon: Icons.settings_outlined,
              label: 'Team Settings',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String label,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: context.spacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
        border: Border.all(color: context.colors.textHint.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Icon(icon, color: context.colors.primary, size: 28.r),
          VSpace(context.spacing.sm),
          Text(
            label,
            style: context.titleMedium.copyWith(
              fontWeight: FontWeight.w900,
              color: context.colors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionCard(BuildContext context) {
    return InkWell(
      onTap: () => BridgeDialogs.showProjectCompleted(context),
      borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
      child: Container(
        padding: EdgeInsets.all(context.spacing.lg),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: const BoxDecoration(
                color: Color(0xFF0D47A1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check, color: Colors.white, size: 24.r),
            ),
            HSpace(context.spacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Project Completion',
                    style: context.titleMedium.copyWith(
                      fontWeight: FontWeight.w900,
                      color: context.colors.textPrimary,
                    ),
                  ),
                  Text(
                    'Mark this project as completed when all tasks are done',
                    style: context.labelSmall.copyWith(
                      color: context.colors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
