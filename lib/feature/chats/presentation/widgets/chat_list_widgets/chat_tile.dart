import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_colors.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/chats/data/models/chat_model.dart';
import 'package:flutter/material.dart';


class ChatTile extends StatelessWidget {
  final ChatModel chat;
  final bool isSelected;
  final VoidCallback? onTap;

  const ChatTile({
    super.key,
    required this.chat,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radius20),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing10, vertical: AppSpacing.height10),
        decoration: BoxDecoration(
          border: Border.all(color: context.colors.primaryLight, width: 1),
          color: isSelected ? context.colors.primary.withValues(alpha: .07): context.colors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radius18),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: AppSpacing.radius20,
                      backgroundImage: NetworkImage(chat.image),
                    ),
                    if (chat.isOnline)
                      Positioned(
                        bottom: 0,
                        right: -1,
                        child: Container(
                          width: AppSpacing.spacing12,
                          height: AppSpacing.spacing12,
                          decoration: BoxDecoration(
                            color: context.colors.success,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: context.colors.surface,
                              width: AppSpacing.spacing2,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                HorizontalSpacing(AppSpacing.spacing10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        chat.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: AppSpacing.fontSize14,
                          fontWeight: FontWeight.w700,
                          color: context.colors.textPrimary,
                        ),
                      ),
                      VerticalSpacing(AppSpacing.height3),
                      Text(
                        chat.message,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: AppSpacing.fontSize12,
                          color: context.colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                HorizontalSpacing(AppSpacing.spacing10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      chat.time,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontSize: AppSpacing.fontSize11,
                        fontWeight: FontWeight.w600,
                        color: context.colors.textPrimary,
                      ),
                    ),
                    VerticalSpacing(AppSpacing.height10),
                    if (chat.unreadCount != null && chat.unreadCount! > 0)
                      Container(
                        width: AppSpacing.spacing24,
                        height: AppSpacing.spacing24,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: context.colors.success,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${chat.unreadCount}',
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontSize: AppSpacing.fontSize11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            if (!isSelected) ...[
              VerticalSpacing(AppSpacing.height10),
            ],
          ],
        ),
      ),
    );
  }
}
