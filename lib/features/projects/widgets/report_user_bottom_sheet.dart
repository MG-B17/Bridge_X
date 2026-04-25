import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';
import '../../../../core/widgets/h_space.dart';
import '../../../../core/widgets/bridge_app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/bridge_dialogs.dart';

class ReportUserBottomSheet extends StatefulWidget {
  final String userName;
  final String userRole;
  final String userAvatar;

  const ReportUserBottomSheet({
    super.key,
    required this.userName,
    required this.userRole,
    required this.userAvatar,
  });

  @override
  State<ReportUserBottomSheet> createState() => _ReportUserBottomSheetState();
}

class _ReportUserBottomSheetState extends State<ReportUserBottomSheet> {
  String _selectedReason = 'Other';

  final List<String> _reasons = [
    'Not contributing',
    'Missed deadlines',
    'Inappropriate behavior',
    'Spam or irrelevant messages',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          VSpace(12.h),
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: context.colors.textHint.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Report User',
                      style: context.titleLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        color: context.colors.textPrimary,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close, color: context.colors.textPrimary, size: 24.sp),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                VSpace(20.h),
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 24.r,
                        backgroundImage: NetworkImage(widget.userAvatar),
                      ),
                      HSpace(12.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.userName,
                            style: context.bodyLarge.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.colors.textPrimary,
                            ),
                          ),
                          Text(
                            widget.userRole,
                            style: context.labelSmall.copyWith(
                              color: context.colors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                VSpace(24.h),
                Text(
                  'SELECT A REASON',
                  style: context.labelSmall.copyWith(
                    color: context.colors.textSecondary,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
                VSpace(12.h),
                ..._reasons.map((reason) => _buildReasonItem(reason)),
                VSpace(20.h),
                AppTextField(
                  hintText: 'Describe the issue...',
                  maxLines: 4,
                ),
                VSpace(30.h),
                AppButton(
                  label: 'Submit Report',
                  backgroundColor: const Color(0xFFC53030),
                  onPressed: () {
                    Navigator.pop(context, true);
                    BridgeDialogs.showReportSubmitted(context);
                  },
                ),
                VSpace(12.h),
                AppButton(
                  label: 'Cancel',
                  isSecondary: true,
                  backgroundColor: const Color(0xFFE5E7EB),
                  onPressed: () => Navigator.pop(context),
                ),
                VSpace(24.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReasonItem(String reason) {
    final bool isSelected = _selectedReason == reason;
    return InkWell(
      onTap: () => setState(() => _selectedReason = reason),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              reason,
              style: context.bodyMedium.copyWith(
                color: context.colors.textPrimary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            Container(
              width: 22.r,
              height: 22.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? context.colors.primary : context.colors.textHint.withValues(alpha: 0.5),
                  width: 2.w,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10.r,
                        height: 10.r,
                        decoration: BoxDecoration(
                          color: context.colors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
