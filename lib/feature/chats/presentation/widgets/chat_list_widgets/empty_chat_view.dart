import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_gradient.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';

class EmptyChatView extends StatelessWidget {
  const EmptyChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          children: [
            VerticalSpacing(AppSpacing.height80),
            Container(
              width: AppSpacing.spacing280,
              height: AppSpacing.height280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSpacing.radius32),
                gradient: AppGradient.tinted(
                  from: context.colors.primaryLight.withValues(alpha: 0.5),
                  to: context.colors.background,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.smart_toy,
                  size: AppSpacing.fontSize90,
                  color: context.colors.primary,
                ),
              ),
            ),
            VerticalSpacing(AppSpacing.height40),
            Text(
              'No messages yet',
              style: TextStyle(
                fontSize: AppSpacing.fontSize30,
                fontWeight: FontWeight.bold,
                color: context.colors.secondary,
              ),
            ),
            VerticalSpacing(AppSpacing.height20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing40),
              child: Text(
                'Start a conversation with your team to stay synced and collaborative. Real-time updates help everyone move faster.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AppSpacing.fontSize18,
                  color: context.colors.textSecondary,
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
