import 'package:bridge_x/core/extensions/theme_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({
    super.key,
    required this.prefixText,
    required this.actionText,
    required this.onActionTap,
  });

  final String prefixText;
  final String actionText;
  final VoidCallback onActionTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: RichText(
            text: TextSpan(
              text: prefixText,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colors.primary,
              ),
              children: [
                TextSpan(
                  text: actionText,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = onActionTap,
                ),
              ],
            ),
          ),
        ),
        VerticalSpacing(AppSpacing.xxl),
        SvgPicture.asset(
          'assets/svgs/Bridge_x_name_icon.svg',
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}
