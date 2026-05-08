import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      children: [
        Center(
          child: RichText(
            text: TextSpan(
              text: AppStrings.noAccountPrefix,
              style: context.textTheme.bodyMedium?.copyWith(
                color: colors.textSecondary,
              ),
              children: [
                TextSpan(
                  text: AppStrings.signUp,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      
                    },
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
