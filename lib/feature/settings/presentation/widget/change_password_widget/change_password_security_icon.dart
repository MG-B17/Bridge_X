import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:flutter/material.dart';

class ChangePasswordSecurityIcon extends StatelessWidget {
  const ChangePasswordSecurityIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: AppSpacing.iconBoxSize * 1.8,
        height: AppSpacing.iconBoxSize * 1.8,
        decoration: BoxDecoration(
          color: context.colors.primary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(AppSpacing.radius12),
        ),
        child: Icon(
          Icons.lock_clock_outlined,
          color: context.colors.primary,
          size: AppSpacing.spacing40,
        ),
      ),
    );
  }
}
