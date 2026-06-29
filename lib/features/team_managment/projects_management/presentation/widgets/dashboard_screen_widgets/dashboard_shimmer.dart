import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardShimmer extends StatelessWidget {
  const DashboardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VerticalSpacing(AppSpacing.spacing16),
        _headerSection(),
        VerticalSpacing(AppSpacing.spacing24),
        _statsRow(),
        VerticalSpacing(AppSpacing.spacing24),
        _teamMembersSection(),
        VerticalSpacing(AppSpacing.spacing24),
        _actionButtons(),
        VerticalSpacing(AppSpacing.spacing24),
        _completionCard(),
        VerticalSpacing(AppSpacing.spacing16),
      ],
    );
  }

  Widget _headerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Project Title Placeholder',
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
        ),
        VerticalSpacing(AppSpacing.spacing4),
        Text(
          'Project subtitle or status placeholder text',
          style: TextStyle(fontSize: 14.sp),
        ),
      ],
    );
  }

  Widget _statsRow() {
    return Row(
      children: [
        Expanded(child: _statCard()),
        SizedBox(width: AppSpacing.spacing12),
        Expanded(child: _statCard()),
        SizedBox(width: AppSpacing.spacing12),
        Expanded(child: _statCard()),
      ],
    );
  }

  Widget _statCard() {
    return Container(
      padding: EdgeInsets.all(AppSpacing.spacing12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text(
            'Stat',
            style: TextStyle(fontSize: 12.sp),
          ),
          VerticalSpacing(AppSpacing.spacing4),
          Text(
            'Value',
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              5,
              (_) => Padding(
                padding: EdgeInsets.only(right: AppSpacing.spacing8),
                child: Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
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

  Widget _completionCard() {
    return Container(
      width: double.infinity,
      height: 100.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
    );
  }
}
