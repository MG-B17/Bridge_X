import 'package:flutter/material.dart';
import '../../../core/utils/extensions.dart';

class AuthFooter extends StatelessWidget {
  final String questionText;
  final String actionText;
  final VoidCallback onActionTap;

  const AuthFooter({
    super.key,
    required this.questionText,
    required this.actionText,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: context.spacing.lg),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6), // Light grey footer
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(context.spacing.radiusCardLarge),
          bottomRight: Radius.circular(context.spacing.radiusCardLarge),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            questionText,
            style: context.bodyMedium.copyWith(
              color: context.colors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextButton(
            onPressed: onActionTap,
            style: TextButton.styleFrom(
              foregroundColor: context.colors.primary,
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              actionText,
              style: context.bodyMedium.copyWith(
                color: context.colors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
