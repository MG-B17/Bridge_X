import 'package:flutter/material.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';

class BubbleContent extends StatelessWidget {
  final String? message;
  final bool isMe;
  final Widget? content;

  const BubbleContent({
    super.key,
    this.message,
    required this.isMe,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.all(context.spacing.md),
        decoration: BoxDecoration(
          color: isMe ? context.colors.primary : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(context.spacing.radiusCardLarge),
            topRight: Radius.circular(context.spacing.radiusCardLarge),
            bottomLeft: Radius.circular(isMe ? context.spacing.radiusCardLarge : 0),
            bottomRight: Radius.circular(isMe ? 0 : context.spacing.radiusCardLarge),
          ),
          boxShadow: [
            if (!isMe)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (content != null) content!,
            if (content != null && message != null) VSpace(context.spacing.sm),
            if (message != null)
              Text(
                message!,
                style: context.bodyMedium.copyWith(
                  color: isMe ? Colors.white : context.colors.textPrimary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
