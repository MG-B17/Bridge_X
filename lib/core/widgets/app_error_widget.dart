import 'package:flutter/material.dart';
import '../utils/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const AppErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 48.w,
            ),
            SizedBox(height: 16.h),
            Text(
              message,
              style: context.bodyMedium.copyWith(color: context.colors.textPrimary),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Retry',
                  style: context.bodyMedium.copyWith(color: Colors.white),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
