import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/theme_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_shadow.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          AppStrings.chats,
          style: AppTextStyles.displayLarge.copyWith(
            color: context.colors.primary,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            
          },
          child: Container(
            width: AppSpacing.spacing40,
            height: AppSpacing.spacing40,
            decoration: BoxDecoration(
              color: context.colors.surface,
              shape: BoxShape.circle,
              boxShadow: AppShadow.subtle,
            ),
            child: Icon(
              Icons.search,
              color: context.colors.primary,
              size: AppSpacing.spacing20,
            ),
          ),
        ),
      ],
    );
  }
}
