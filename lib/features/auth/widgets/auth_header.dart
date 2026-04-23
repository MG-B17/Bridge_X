import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/v_space.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  const AuthHeader({super.key, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Text(
            title,
            style: context.displayLarge.copyWith(
              color: context.colors.primary,
              fontSize: 26.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        if (subtitle != null) ...[
          VSpace(context.spacing.sm),
          Center(
            child: Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: context.bodyMedium.copyWith(
                color: context.colors.textSecondary,
                height: 1.5,
              ),
            ),
          ),
        ],
        VSpace(32.h),
      ],
    );
  }
}
