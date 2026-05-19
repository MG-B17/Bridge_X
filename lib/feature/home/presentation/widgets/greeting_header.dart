import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';

import 'notification_bell_button.dart';

class GreetingHeader extends StatelessWidget {
  const GreetingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.hiGreeting,
                style: AppTextStyles.displayLarge.copyWith(
                  color: context.colors.textPrimary,
                ),
              ),
              VerticalSpacing(AppSpacing.spacing4),
              Text(
                AppStrings.greetingSubtitle,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: context.colors.textSecondary,
                ),
              ),
            ],
          ),
        ),

        
        const NotificationBellButton(),
      ],
    );
  }
}
