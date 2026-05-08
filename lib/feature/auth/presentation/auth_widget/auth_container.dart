import 'package:bridge_x/core/extensions/theme_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthContainer extends StatelessWidget {
  const AuthContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.xxl),
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSpacing.radiusPill + 25.r),
          topRight: Radius.circular(AppSpacing.radiusPill + 25.r),
        ),
        boxShadow: [
          BoxShadow(
            color: context.colors.primaryLight.withValues(alpha: 0.18),
            blurRadius: 30,
            spreadRadius: 10,
            offset: const Offset(10, 0),
          ),
        ],
      ),
      child: child,
    );
  }
}
