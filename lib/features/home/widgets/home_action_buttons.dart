import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/h_space.dart';
import '../../../../core/utils/extensions.dart';

class HomeActionButtons extends StatelessWidget {
  const HomeActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: context.colors.primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(context.spacing.radiusCard),
              ),
              elevation: 0,
            ),
            icon: Icon(Icons.group_add_outlined, size: 20.w),
            label: Text(
              'Join Team',
              style: context.bodyMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        HSpace(context.spacing.sm),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: context.colors.primary,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              side: BorderSide(color: context.colors.primary, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(context.spacing.radiusCard),
              ),
            ),
            icon: Icon(Icons.add_circle_outline, size: 20.w),
            label: Text(
              'Create Team',
              style: context.bodyMedium.copyWith(
                color: context.colors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
