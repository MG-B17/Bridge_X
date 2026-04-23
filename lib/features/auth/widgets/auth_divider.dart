import 'package:flutter/material.dart';
import '../../../core/utils/extensions.dart';

class AuthDivider extends StatelessWidget {
  final String text;

  const AuthDivider({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: context.colors.textHint.withValues(alpha: 0.3))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.spacing.md),
          child: Text(
            text.toUpperCase(),
            style: context.labelSmall.copyWith(
              color: context.colors.textHint,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(child: Divider(color: context.colors.textHint.withValues(alpha: 0.3))),
      ],
    );
  }
}
