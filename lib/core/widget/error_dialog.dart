import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_colors.dart';
import 'package:bridge_x/core/widget/bridge_x_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorDialog {
  static Future<void> show({
    required BuildContext context,
    required String title,
    required String message,
    String actionLabel = 'OK',
    VoidCallback? onAction,
    bool isDismissible = true,
  }) async {
    final colors = context.colors;

    return showDialog(
      context: context,
      barrierColor: AppColors.errorDialogBg.withValues(alpha: .3),
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: colors.surface,
          insetPadding: EdgeInsets.symmetric(horizontal: 24.w),

          contentPadding: EdgeInsets.all(20.w),

          content: SizedBox(
            height: 180.h,
            width: 320.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 10.h,
              children: [
                Icon(Icons.error_outline, color: colors.error, size: 35.sp),

                

                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: colors.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                

                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium?.copyWith(color: colors.textPrimary),
                ),

                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onAction?.call();
                      },
                      child: Text(actionLabel, style: TextStyle(color: colors.error)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<bool> showConfirm({
    required BuildContext context,
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
  }) async {
    final colors = context.colors;

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.warning_outlined, color: colors.warning, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          content: Text(message, style: context.textTheme.bodyMedium),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(cancelLabel)),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(confirmLabel, style: TextStyle(color: colors.error)),
            ),
          ],
        );
      },
    );

    return result ?? false;
  }
}

class ErrorSnackBar {
  static void show(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 4),
  }) {
    BridgeXSnackBar.showError(context: context, message: message, duration: duration);
  }

  static void showSuccess(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    BridgeXSnackBar.showSuccess(context: context, message: message, duration: duration);
  }

  static void showWarning(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 4),
  }) {
    BridgeXSnackBar.showWarning(context: context, message: message, duration: duration);
  }
}
