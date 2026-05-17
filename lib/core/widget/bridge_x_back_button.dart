import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Circular back-arrow button used across multiple screens.
///
/// By default it calls `context.pop()`. Pass [onTap] to override.
class BridgeXBackButton extends StatelessWidget {
  const BridgeXBackButton({
    super.key,
    this.onTap,
    this.backgroundColor,
    this.iconColor,
    this.boxShadow,
  });

  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? iconColor;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: onTap ?? () => context.pop(),
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: backgroundColor ?? colors.surface,
          shape: BoxShape.circle,
          boxShadow: boxShadow ?? AppSpacing.subtleShadow,
        ),
        child: Icon(
          Icons.arrow_back,
          color: iconColor ?? colors.indigo,
          size: 20.sp,
        ),
      ),
    );
  }
}
