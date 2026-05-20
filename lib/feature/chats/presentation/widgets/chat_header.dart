import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.primaryLight,
        borderRadius: BorderRadius.circular(AppSpacing.radius20),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.spacing12),
        child: Row(
          children: [
            IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.teamAlpha,
                  style: AppTextStyles.headlineSmall.copyWith(
                    color: context.colors.textPrimary,
                  ),
                ),
                Text(
                  AppStrings.membersOnline,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: context.colors.textSecondary,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.info_outline_rounded,
              color: context.colors.textSecondary,
              size: AppSpacing.spacing20,
            ),
          ],
        ),
      ),
    );
  }
}
