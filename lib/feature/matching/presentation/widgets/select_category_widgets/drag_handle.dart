import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:flutter/material.dart';

class DragHandle extends StatelessWidget {
  const DragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: AppSpacing.spacing40,
        height: AppSpacing.height4,
        decoration: BoxDecoration(
          color: context.colors.primary.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(AppSpacing.radius2),
        ),
      ),
    );
  }
}
