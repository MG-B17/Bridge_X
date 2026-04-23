import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/h_space.dart';
import '../../../../core/widgets/v_space.dart';
import '../../../../core/utils/extensions.dart';

class CircularProductivityChart extends StatelessWidget {
  const CircularProductivityChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.spacing.xl),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
        boxShadow: [context.spacing.cardShadow],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 90.w,
            height: 90.w,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 0.65,
                  strokeWidth: 12.w,
                  backgroundColor: context.colors.textHint.withValues(alpha: 0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(context.colors.primary),
                ),
                Center(
                  child: Text(
                    '65%',
                    style: context.displayLarge.copyWith(
                      color: context.colors.textPrimary,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
          HSpace(context.spacing.xxl),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildLegendItem(
                  context,
                  color: context.colors.primary,
                  label: 'Completed Tasks',
                ),
                VSpace(context.spacing.md),
                _buildLegendItem(
                  context,
                  color: context.colors.textHint.withValues(alpha: 0.2),
                  label: 'Active Tasks',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(BuildContext context, {required Color color, required String label}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10.w,
          height: 10.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        HSpace(context.spacing.sm),
        Text(
          label,
          style: context.bodyMedium.copyWith(
            color: context.colors.textSecondary,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
