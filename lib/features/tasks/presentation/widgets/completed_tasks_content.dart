import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/h_space.dart';
import '../../../../core/widgets/v_space.dart';
import 'completed_task_item.dart';

class CompletedTasksContent extends StatelessWidget {
  const CompletedTasksContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStatsRow(context),
        VSpace(context.spacing.xxl),
        _buildSectionHeader(context),
        VSpace(context.spacing.md),
        _buildCompletedTasksList(),
        VSpace(context.spacing.lg),
        const GoalBanner(),
      ],
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    return Row(
      children: [
        _CompletionStatCard(
          label: AppStrings.totalDone,
          value: '124',
          icon: Icons.check_circle_outline_rounded,
          iconColor: context.colors.completedText,
        ),
        HSpace(context.spacing.md),
        _CompletionStatCard(
          label: AppStrings.thisWeek,
          value: '18',
          icon: Icons.trending_up_rounded,
          iconColor: context.colors.primary,
        ),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Row(
      children: [
        Text(
          AppStrings.recentlyFinished,
          style: context.titleLarge.copyWith(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
        HSpace(context.spacing.sm),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: context.colors.divider.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(context.spacing.radiusPill),
          ),
          child: Text(
            '48',
            style: context.labelSmall.copyWith(
              color: context.colors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompletedTasksList() {
    return const Column(
      children: [
        CompletedTaskItem(
          title: 'Update README\nDocumentation',
          completedDate: 'Completed Oct 20',
        ),
        CompletedTaskItem(
          title: 'Weekly Standup Report',
          completedDate: 'Completed Oct 19',
        ),
        CompletedTaskItem(
          title: 'Client Feedback Integration',
          completedDate: 'Completed Oct 18',
        ),
        CompletedTaskItem(
          title: 'API Endpoint Security Audit',
          completedDate: 'Completed Oct 15',
        ),
      ],
    );
  }
}

class _CompletionStatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;

  const _CompletionStatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(context.spacing.md),
        decoration: BoxDecoration(
          color: context.colors.secondary.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label.toUpperCase(),
              style: context.labelSmall.copyWith(
                color: context.colors.textSecondary,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.1,
                fontSize: 10.sp,
              ),
            ),
            VSpace(context.spacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: context.displayLarge.copyWith(
                    color: context.colors.textPrimary,
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Icon(icon, color: iconColor, size: 24.w),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GoalBanner extends StatelessWidget {
  const GoalBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.spacing.xl),
      decoration: BoxDecoration(
        color: context.colors.secondary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
      ),
      child: Column(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: context.colors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.emoji_events_rounded,
              color: context.colors.primary,
              size: 22.w,
            ),
          ),
          VSpace(context.spacing.md),
          Text(
            AppStrings.goalSmashed,
            style: context.titleLarge.copyWith(
              color: context.colors.primary,
              fontWeight: FontWeight.w900,
            ),
          ),
          VSpace(context.spacing.sm),
          Text(
            AppStrings.goalSmashedDesc,
            textAlign: TextAlign.center,
            style: context.bodyMedium.copyWith(
              color: context.colors.textSecondary,
              height: 1.4,
            ),
          ),
          VSpace(context.spacing.md),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: context.colors.primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: context.spacing.xl,
                vertical: context.spacing.sm,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(context.spacing.radiusPill),
              ),
              elevation: 0,
            ),
            child: Text(
              AppStrings.viewInsights,
              style: context.bodyMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
