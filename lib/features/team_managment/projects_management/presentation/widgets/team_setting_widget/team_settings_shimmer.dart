import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeamSettingsShimmer extends StatelessWidget {
  const TeamSettingsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VerticalSpacing(AppSpacing.spacing16),
        Text(
          'Back',
          style: TextStyle(fontSize: 14.sp),
        ),
        VerticalSpacing(AppSpacing.spacing16),
        Text(
          'Team Settings',
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
        ),
        VerticalSpacing(AppSpacing.spacing4),
        Text(
          'Subtitle placeholder',
          style: TextStyle(fontSize: 14.sp),
        ),
        VerticalSpacing(AppSpacing.spacing24),
        _buildCard(children: [
          Text(
            'TEAM INFO',
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
          VerticalSpacing(AppSpacing.spacing16),
          Text(
            'Team name label',
            style: TextStyle(fontSize: 12.sp),
          ),
          VerticalSpacing(AppSpacing.spacing4),
          Text(
            'Team name value',
            style: TextStyle(fontSize: 14.sp),
          ),
          VerticalSpacing(AppSpacing.spacing16),
          Text(
            'Description label',
            style: TextStyle(fontSize: 12.sp),
          ),
          VerticalSpacing(AppSpacing.spacing4),
          Text(
            'Description value placeholder text',
            style: TextStyle(fontSize: 14.sp),
          ),
        ]),
        VerticalSpacing(AppSpacing.spacing24),
        Text(
          'TEAM MEMBERS',
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
        ),
        VerticalSpacing(AppSpacing.spacing12),
        _buildMemberCard(),
        VerticalSpacing(AppSpacing.spacing12),
        _buildMemberCard(),
        VerticalSpacing(AppSpacing.spacing24),
        Text(
          'ASSIGN TASKS',
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
        ),
        VerticalSpacing(AppSpacing.spacing8),
        Container(
          width: double.infinity,
          height: 48.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
        ),
        VerticalSpacing(AppSpacing.spacing24),
        Text(
          'Project control section',
          style: TextStyle(fontSize: 14.sp),
        ),
        VerticalSpacing(AppSpacing.spacing24),
        Text(
          'Danger zone section',
          style: TextStyle(fontSize: 14.sp),
        ),
        VerticalSpacing(AppSpacing.spacing20),
      ],
    );
  }

  Widget _buildCard({required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.spacing16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildMemberCard() {
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
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
          VerticalSpacing(AppSpacing.spacing12),
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
}
