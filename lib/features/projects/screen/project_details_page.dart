import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';
import '../../../../core/widgets/h_space.dart';

class ProjectDetailsPage extends StatelessWidget {
  const ProjectDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              Padding(
                padding: EdgeInsets.all(context.spacing.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProjectSummary(context),
                    VSpace(context.spacing.xl),
                    _buildRoleSection(context),
                    VSpace(context.spacing.xl),
                    _buildTeamSection(context),
                    VSpace(context.spacing.xl),
                    _buildReviewSection(context),
                    VSpace(context.spacing.xl),
                    _buildStatsRow(context),
                    VSpace(context.spacing.xl),
                    _buildImpactSection(context),
                    VSpace(context.spacing.xxl),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.spacing.lg, vertical: context.spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: context.colors.primary, size: 28.r),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          VSpace(context.spacing.md),
          Container(
            padding: EdgeInsets.all(context.spacing.lg),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
              border: Border.all(color: context.colors.textHint.withValues(alpha: 0.1)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 60.r,
                  height: 60.r,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D47A1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(Icons.eco, color: Colors.white, size: 32.r),
                ),
                HSpace(context.spacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Q3 Marketing Audit',
                        style: context.headlineSmall.copyWith(
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF0D47A1),
                        ),
                      ),
                      Text(
                        'Sustainable Living Platform',
                        style: context.bodyMedium.copyWith(
                          color: context.colors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      VSpace(context.spacing.xs),
                      _buildStatusBadge(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(context.spacing.radiusPill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, color: Colors.green.shade700, size: 14.r),
          HSpace(4.w),
          Text(
            'COMPLETED',
            style: context.labelSmall.copyWith(
              color: Colors.green.shade700,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectSummary(BuildContext context) {
    return Text(
      'Comprehensive analysis of seasonal campaign performance and ROI metrics for the global sustainable product lines across multiple regions.',
      style: context.bodyLarge.copyWith(
        color: context.colors.textSecondary,
        height: 1.5,
      ),
    );
  }

  Widget _buildRoleSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.spacing.lg),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2FF),
        borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.group_work, color: context.colors.primary, size: 20.r),
              HSpace(context.spacing.sm),
              Text(
                'MY ROLE',
                style: context.labelSmall.copyWith(
                  color: context.colors.primary,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          VSpace(context.spacing.sm),
          Text(
            'Fullstack Developer',
            style: context.titleLarge.copyWith(
              fontWeight: FontWeight.w900,
              color: context.colors.textPrimary,
            ),
          ),
          VSpace(context.spacing.xs),
          Text(
            'Implemented the secure checkout flow and integrated Stripe API.',
            style: context.bodyMedium.copyWith(
              color: context.colors.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Team Members',
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: context.colors.textPrimary,
          ),
        ),
        VSpace(context.spacing.md),
        Row(
          children: [
            _buildAvatar('https://i.pravatar.cc/150?u=1'),
            HSpace(context.spacing.md),
            _buildAvatar('https://i.pravatar.cc/150?u=2'),
            HSpace(context.spacing.md),
            _buildAvatar('https://i.pravatar.cc/150?u=3'),
          ],
        ),
      ],
    );
  }

  Widget _buildAvatar(String url) {
    return CircleAvatar(
      radius: 28.r,
      backgroundImage: NetworkImage(url),
    );
  }

  Widget _buildReviewSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.spacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
        border: Border.all(color: context.colors.textHint.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 24.r),
                  HSpace(context.spacing.sm),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '4.9 ',
                          style: context.titleLarge.copyWith(
                            fontWeight: FontWeight.w900,
                            color: context.colors.textPrimary,
                          ),
                        ),
                        TextSpan(
                          text: '/ 5',
                          style: context.bodyMedium.copyWith(
                            color: context.colors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFDBEAFE),
                  borderRadius: BorderRadius.circular(context.spacing.radiusPill),
                ),
                child: Text(
                  'Mentor Choice',
                  style: context.labelSmall.copyWith(
                    color: const Color(0xFF1E40AF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          VSpace(context.spacing.lg),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(context.spacing.md),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              '"Excellent work on the performance optimization and API security."',
              style: context.bodyMedium.copyWith(
                color: context.colors.textSecondary,
                fontStyle: FontStyle.italic,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildStatCard(context, Icons.access_time, 'DURATION', '3 months')),
        HSpace(context.spacing.md),
        Expanded(child: _buildStatCard(context, Icons.calendar_today, 'COMPLETED', 'Oct 12, 2023')),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, IconData icon, String label, String value) {
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
          Icon(icon, color: context.colors.textSecondary, size: 24.r),
          VSpace(context.spacing.sm),
          Text(
            label,
            style: context.labelSmall.copyWith(
              color: context.colors.textSecondary,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
          VSpace(context.spacing.xs),
          Text(
            value,
            style: context.titleMedium.copyWith(
              fontWeight: FontWeight.w900,
              color: context.colors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImpactSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.spacing.xl),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3B82F6), Color(0xFF1E40AF)],
        ),
        borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'YOUR IMPACT',
            style: context.labelSmall.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
          VSpace(context.spacing.lg),
          _buildImpactItem(context, Icons.trending_down, 'Reduced load time by 40% through lazy loading and asset optimization.'),
          VSpace(context.spacing.lg),
          _buildImpactItem(context, Icons.devices, 'Built responsive dashboard supporting 15+ complex data visualizations.'),
        ],
      ),
    );
  }

  Widget _buildImpactItem(BuildContext context, IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.white, size: 24.r),
        HSpace(context.spacing.md),
        Expanded(
          child: Text(
            text,
            style: context.bodyMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
