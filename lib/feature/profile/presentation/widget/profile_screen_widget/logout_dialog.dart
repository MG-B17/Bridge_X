import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LogoutDialog {
  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          AppStrings.logoutTitle,
          style: AppTextStyles.headlineSmall.copyWith(color: context.colors.textPrimary),
        ),
        content: Text(
          AppStrings.logoutConfirm,
          style: AppTextStyles.bodyMedium.copyWith(color: context.colors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(context),
            child: Text(
              AppStrings.cancel,
              style: AppTextStyles.titleMedium.copyWith(color: context.colors.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () {
              context.pop(context);
            },
            child: Text(
              AppStrings.logout,
              style: AppTextStyles.titleMedium.copyWith(color: context.colors.error),
            ),
          ),
        ],
      ),
    );
  }
}
