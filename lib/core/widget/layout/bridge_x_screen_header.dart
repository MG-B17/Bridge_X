import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_back_button.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:flutter/material.dart';

class BridgeXScreenHeader extends StatelessWidget {
  const BridgeXScreenHeader({
    required this.title,
    this.titleStyle,
    this.backButtonBgColor,
    this.backButtonIconColor,
    this.backButtonShadow,
    this.spacing,
    super.key,
  });

  final String title;
  final TextStyle? titleStyle;
  final Color? backButtonBgColor;
  final Color? backButtonIconColor;
  final List<BoxShadow>? backButtonShadow;
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BridgeXBackButton(
          backgroundColor: backButtonBgColor,
          iconColor: backButtonIconColor,
          boxShadow: backButtonShadow,
        ),
        HorizontalSpacing(spacing ?? AppSpacing.md),
        Text(
          title,
          style: titleStyle ??
              AppTextStyles.displayLarge.copyWith(
                color: context.colors.ongoingText, // Or exact dark blue
                fontWeight: FontWeight.w800,
              ),
        ),
      ],
    );
  }
}
