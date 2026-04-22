import 'package:flutter/material.dart';
import 'package:bridgex/core/utils/extensions.dart';
import 'package:bridgex/core/constant/app_spacing.dart';
import 'package:bridgex/core/widgets/bridge_app_button.dart';

class AppErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final String? retryText;

  const AppErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
    this.retryText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 64,
              color: Colors.red.withOpacity(0.8),
            ),
            SizedBox(height: AppSpacing.md),
            Text(
              message,
              style: context.bodyLarge.copyWith(
                color: context.colors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              SizedBox(height: AppSpacing.xl),
              AppButton(
                text: retryText ?? 'Try Again',
                onPressed: onRetry!,
                width: 150,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
