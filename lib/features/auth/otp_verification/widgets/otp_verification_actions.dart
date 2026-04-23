import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';

class OtpVerificationActions extends StatelessWidget {
  const OtpVerificationActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: RichText(
            text: TextSpan(
              style: context.bodyMedium.copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
              children: [
                const TextSpan(text: 'Resend code in '),
                TextSpan(
                  text: '00:30',
                  style: TextStyle(
                    color: context.colors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        VSpace(context.spacing.md),
        Center(
          child: TextButton(
            onPressed: () => context.pop(),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              AppStrings.wrongEmail,
              style: context.bodyMedium.copyWith(
                color: context.colors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
