import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/app_color_schema.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:flutter/material.dart';

class NoTeamsIllustration extends StatelessWidget {
  const NoTeamsIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Center(
      child: Container(
        width: AppSpacing.width160,
        height: AppSpacing.height100,
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radius12),
          boxShadow: [
            BoxShadow(
              color: context.colors.teal.withValues(alpha: .4),
              blurRadius: 30,
              spreadRadius: 0,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: AppSpacing.spacing30,
              child: CircleAvatar(
                radius: AppSpacing.radius14,
                backgroundColor: colors.divider.withValues(alpha: 0.4),
              ),
            ),
            Positioned(
              right: AppSpacing.spacing30,
              child: CircleAvatar(
                radius: AppSpacing.radius14,
                backgroundColor: colors.divider.withValues(alpha: 0.4),
              ),
            ),
            Container(
              width: AppSpacing.iconBoxSize,
              height: AppSpacing.iconBoxSize,
              decoration: BoxDecoration(
                gradient: AppColorScheme.matching,
                borderRadius: BorderRadius.circular(AppSpacing.radius6),
              ),
              child: Icon(
                Icons.manage_search_rounded,
                color: Colors.white,
                size: AppSpacing.fontSize24,
              ),
            ),
            Positioned(
              top: AppSpacing.height20,
              right: AppSpacing.spacing40,
              child: CircleAvatar(radius: AppSpacing.radius5, backgroundColor: colors.amber),
            ),
          ],
        ),
      ),
    );
  }
}
