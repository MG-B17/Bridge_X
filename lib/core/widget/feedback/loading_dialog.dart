import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_colors.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LoadingDialog {
  const LoadingDialog._();

  static NavigatorState? _navigator;

  static Future<void> show({required BuildContext context, required String message}) async {
    final colors = context.colors;
    _navigator = Navigator.of(context, rootNavigator: true);

    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: AppColors.black.withValues(alpha: .5),
      builder: (context) {
        return AlertDialog(
          backgroundColor: colors.surface,
          insetPadding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing16),
          contentPadding: EdgeInsets.all(20.w),
          content: SizedBox(
            height: AppSpacing.height160,
            width: AppSpacing.spacing260,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              spacing: 16.h,
              children: [
                Lottie.asset(
                  'assets/lottie/loading.json',
                  width: AppSpacing.spacing48,
                  height:AppSpacing.spacing48,
                  repeat: true,
                ),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((_) {
      _navigator = null;
    });
  }

  static void hide([BuildContext? context]) {
    if (_navigator != null) {
      _navigator!.pop();
      _navigator = null;
    } else if (context != null) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
