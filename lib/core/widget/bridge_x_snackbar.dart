import 'package:bridge_x/core/utils/app_shadow.dart';
import 'package:bridge_x/core/constant/app_feedback_messages.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_colors.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Design-system snackbar. All colors, radii, and shadows come from
/// [AppColors] / [AppSpacing] — zero hardcoded values.
class BridgeXSnackBar {
  // ─── Success ────────────────────────────────────────────────────────────────
  static void showSuccess({
    required BuildContext context,
    required String message,
    String title = AppFeedbackMessages.snackbarSuccess,
    Duration duration = const Duration(seconds: 3),
  }) {
    _show(
      context: context,
      title: title,
      message: message,
      duration: duration,
      iconData: Icons.check,
      accentColor: AppColors.snackbarAccent,
    );
  }

  // ─── Error ──────────────────────────────────────────────────────────────────
  static void showError({
    required BuildContext context,
    required String message,
    String title = AppFeedbackMessages.snackbarError,
    Duration duration = const Duration(seconds: 4),
  }) {
    _show(
      context: context,
      title: title,
      message: message,
      duration: duration,
      iconData: Icons.close,
      accentColor: AppColors.error,
    );
  }

  // ─── Warning ────────────────────────────────────────────────────────────────
  static void showWarning({
    required BuildContext context,
    required String message,
    String title = AppFeedbackMessages.snackbarWarning,
    Duration duration = const Duration(seconds: 4),
  }) {
    _show(
      context: context,
      title: title,
      message: message,
      duration: duration,
      iconData: Icons.warning_amber_rounded,
      accentColor: AppColors.warning,
    );
  }

  // ─── Internal builder ───────────────────────────────────────────────────────
  static void _show({
    required BuildContext context,
    required String title,
    required String message,
    required Duration duration,
    required IconData iconData,
    required Color accentColor,
  }) {
    final colors = context.colors;
    final text = context.textTheme;

    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      duration: duration,
      content: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
          border: Border(
            left: BorderSide(color: accentColor, width: AppSpacing.xs),
          ),
          boxShadow: AppShadow.snackBar(accentColor),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm + AppSpacing.xs,
            ),
            child: Row(
              children: [
                // Outer ring
                Container(
                  padding: EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  // Inner filled circle + icon
                  child: Container(
                    padding: EdgeInsets.all(AppSpacing.xs + 1),
                    decoration: BoxDecoration(color: accentColor, shape: BoxShape.circle),
                    child: Icon(iconData, color: AppColors.white, size: 13.sp),
                  ),
                ),
                HorizontalSpacing(AppSpacing.sm + AppSpacing.xs),
                // Title + message
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: text.bodyMedium?.copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        message,
                        style: text.bodySmall?.copyWith(color: colors.textSecondary, height: 1.4),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                HorizontalSpacing(AppSpacing.sm),
                // Dismiss ×
                GestureDetector(
                  onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                  child: Icon(Icons.close, color: colors.textSecondary, size: 17.sp),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}

