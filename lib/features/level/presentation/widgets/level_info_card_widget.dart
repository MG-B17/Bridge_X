import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';

class LevelInfoCardWidget extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final String? badge;

  const LevelInfoCardWidget({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(context.spacing.lg),
        margin: EdgeInsets.only(
          right: label == 'Completed Tasks' ? context.spacing.sm : 0,
          left: label == 'Completed Tasks' ? 0 : context.spacing.sm,
        ),
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(context.spacing.radiusCard),
          border: Border.all(color: context.colors.divider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            VSpace(context.spacing.md),
            Text(
              value,
              style: context.displayLarge.copyWith(
                color: context.colors.textPrimary,
                fontSize: 24.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
            VSpace(context.spacing.xs),
            Text(
              label,
              style: context.bodyMedium.copyWith(
                color: context.colors.textSecondary,
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(icon, color: context.colors.primary, size: 24.w),
        if (badge != null)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: const Color(0xFF7C2D12),
              borderRadius: BorderRadius.circular(context.spacing.radiusXs),
            ),
            child: Text(
              badge!,
              style: context.labelSmall.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 8.sp,
              ),
            ),
          ),
      ],
    );
  }
}
