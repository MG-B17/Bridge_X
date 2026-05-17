import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:flutter/material.dart';

class SettingsVersionText extends StatelessWidget {
  const SettingsVersionText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppStrings.bridgeXVersion,
        style: AppTextStyles.labelSmall.copyWith(
          color: context.colors.textSecondary,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
