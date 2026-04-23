import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/extensions.dart';

class BridgeToast extends StatelessWidget {
  final String message;
  final bool isSuccess;
  final String? actionLabel;
  final VoidCallback? onActionPressed;
  final bool showCloseIcon;

  const BridgeToast({
    super.key,
    required this.message,
    this.isSuccess = true,
    this.actionLabel,
    this.onActionPressed,
    this.showCloseIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(color: context.colors.divider, width: 1.w),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: isSuccess ? const Color(0xFFDBEAFE) : const Color(0xFFFEE2E2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isSuccess ? Icons.check : Icons.error_outline,
                color: isSuccess ? context.colors.primary : const Color(0xFFEF4444),
                size: 14.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                message,
                style: context.bodyMedium.copyWith(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.w500,
                  fontSize: 13.sp,
                ),
              ),
            ),
            if (actionLabel != null)
              TextButton(
                onPressed: onActionPressed,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  actionLabel!,
                  style: context.labelSmall.copyWith(
                    color: context.colors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            if (showCloseIcon) ...[
              SizedBox(width: 8.w),
              Icon(
                Icons.close_rounded,
                color: context.colors.textHint.withValues(alpha: 0.5),
                size: 16.sp,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
