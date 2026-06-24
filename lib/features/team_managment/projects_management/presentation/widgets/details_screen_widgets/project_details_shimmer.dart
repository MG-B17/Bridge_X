import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectDetailsShimmer extends StatelessWidget {
  const ProjectDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _headerCard(),
        VerticalSpacing(AppSpacing.spacing16),
        _roleCard(),
        VerticalSpacing(AppSpacing.spacing16),
        _teamMembersSection(),
        VerticalSpacing(AppSpacing.spacing24),
        _actionButtons(),
        VerticalSpacing(AppSpacing.spacing32),
      ],
    );
  }

  Widget _headerCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.spacing16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Project Title Placeholder',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          VerticalSpacing(AppSpacing.spacing8),
          Text(
            'Project description placeholder text that gives a brief overview of the project.',
            style: TextStyle(fontSize: 14.sp),
          ),
          VerticalSpacing(AppSpacing.spacing12),
          Text(
            'Status badge placeholder',
            style: TextStyle(fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  Widget _roleCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.spacing16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'MY ROLE',
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
          VerticalSpacing(AppSpacing.spacing8),
          Text(
            'Role title placeholder',
            style: TextStyle(fontSize: 14.sp),
          ),
        ],
      ),
    );
  }

  Widget _teamMembersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TEAM MEMBERS',
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
        ),
        VerticalSpacing(AppSpacing.spacing12),
        _memberCard(),
        VerticalSpacing(AppSpacing.spacing8),
        _memberCard(),
        VerticalSpacing(AppSpacing.spacing8),
        _memberCard(),
      ],
    );
  }

  Widget _memberCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.spacing16,
        vertical: AppSpacing.spacing12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
          SizedBox(width: AppSpacing.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Member name',
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Track name',
                  style: TextStyle(fontSize: 12.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButtons() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 48.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
        ),
        VerticalSpacing(AppSpacing.spacing12),
        Container(
          width: double.infinity,
          height: 48.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
