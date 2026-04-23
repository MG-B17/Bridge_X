import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';

class StatCardWidget extends StatelessWidget {
  final String value;
  final String label;
  final VoidCallback? onTap;

  const StatCardWidget({
    super.key,
    required this.value,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: context.spacing.xs),
          padding: EdgeInsets.symmetric(
            vertical: context.spacing.lg,
            horizontal: context.spacing.xs,
          ),
          decoration: BoxDecoration(
            color: context.colors.divider.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(context.spacing.radiusCard),
            border: Border.all(color: context.colors.divider),
          ),
          child: Column(
            children: [
              Text(
                value,
                style: context.displayLarge.copyWith(
                  color: context.colors.primary,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              VSpace(context.spacing.xs),
              Text(
                label,
                textAlign: TextAlign.center,
                style: context.labelSmall.copyWith(
                  color: context.colors.textSecondary,
                  fontWeight: FontWeight.w900,
                  fontSize: 9.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
