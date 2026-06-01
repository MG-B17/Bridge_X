import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_colors.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/chats/data/models/message_model.dart';
import 'package:flutter/material.dart';


class MessageBubble extends StatelessWidget {
  final MessageModel messageModel;
  final Widget? customContent;

  const MessageBubble({
    super.key,
    required this.messageModel,
    this.customContent,
  });

  @override
  Widget build(BuildContext context) {
    if (messageModel.isMe) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'You',
            style: AppTextStyles.bodyMedium.copyWith(
              color: context.colors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          VerticalSpacing(AppSpacing.height8),
          Container(
            constraints: BoxConstraints(
              maxWidth: AppSpacing.spacing260,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.spacing18,
              vertical: AppSpacing.height16,
            ),
            decoration: BoxDecoration(
              color: context.colors.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSpacing.radius28),
                topRight: Radius.circular(AppSpacing.radius28),
                bottomLeft: Radius.circular(AppSpacing.radius28),
                bottomRight: Radius.circular(AppSpacing.radius8),
              ),
            ),
            child: Text(
              messageModel.message,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.white,
                height: 1.5,
              ),
            ),
          ),
          VerticalSpacing(AppSpacing.height8),
          Text(
            messageModel.time,
            style: AppTextStyles.bodyMedium.copyWith(
              color: context.colors.textSecondary,
              fontSize: AppSpacing.fontSize12,
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          messageModel.senderName,
          style: AppTextStyles.bodyMedium.copyWith(
            color: context.colors.textSecondary,
            fontWeight: FontWeight.w700,
          ),
        ),
        VerticalSpacing(AppSpacing.height10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CircleAvatar(
              radius: AppSpacing.radius18,
              backgroundImage: AssetImage(messageModel.avatar),
            ),
            HorizontalSpacing(AppSpacing.spacing10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: AppSpacing.spacing260,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.spacing16,
                      vertical: AppSpacing.height16,
                    ),
                    decoration: BoxDecoration(
                      color: context.colors.surface,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppSpacing.radius8),
                        topRight: Radius.circular(AppSpacing.radius28),
                        bottomLeft: Radius.circular(AppSpacing.radius28),
                        bottomRight: Radius.circular(AppSpacing.radius28),
                      ),
                      border: Border.all(
                        color: context.colors.divider,
                      ),
                    ),
                    child: customContent ??
                        Text(
                          messageModel.message,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: context.colors.textPrimary,
                            height: 1.6,
                          ),
                        ),
                  ),
                  VerticalSpacing(AppSpacing.height8),
                  Padding(
                    padding: EdgeInsets.only(left: AppSpacing.spacing4),
                    child: Text(
                      messageModel.time,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: context.colors.textSecondary,
                        fontSize: AppSpacing.fontSize12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
