import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_colors.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/features/chat/domain/entities/chat_room_entity.dart';

class ChatRoomListTile extends StatelessWidget {
  final ChatRoomEntity chatRoom;
  final ValueChanged<String> onTapped;

  const ChatRoomListTile({
    super.key,
    required this.chatRoom,
    required this.onTapped,
  });

  static final _timeFormat = DateFormat('h:mm a');
  static final _weekdayFormat = DateFormat('EEEE');
  static final _dateFormat = DateFormat('MMM dd');
  static const _yesterdayLabel = 'Yesterday';
  static const _noMessagesLabel = 'No messages yet';
  static const _badgeOverflow = '99+';
  static const double _trailingWidth = 80;

  String _formatMessageTime(DateTime? date) {
    if (date == null) return '';
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(date.year, date.month, date.day);

    if (messageDate == today) {
      return _timeFormat.format(date);
    } else if (messageDate == yesterday) {
      return _yesterdayLabel;
    } else if (now.difference(date).inDays < 7) {
      return _weekdayFormat.format(date);
    } else {
      return _dateFormat.format(date);
    }
  }

  static const _avatarPalette = [
    AppColors.primaryBlue,
    AppColors.burgundy,
    AppColors.gold,
    AppColors.teal,
    AppColors.indigo,
    AppColors.amber,
  ];

  static const _avatarIcons = [
    Icons.smart_toy_rounded,
    Icons.terminal_rounded,
    Icons.cloud_done_rounded,
    Icons.grid_view_rounded,
    Icons.group_rounded,
    Icons.star_rounded,
  ];

  Widget _buildAvatar(BuildContext context) {
    final hash = chatRoom.teamName.hashCode;
    final color = _avatarPalette[hash.abs() % _avatarPalette.length];
    final icon = _avatarIcons[hash.abs() % _avatarIcons.length];

    return CircleAvatar(
      radius: AppSpacing.radius28,
      backgroundColor: color.withValues(alpha: 0.15),
      child: Icon(icon, color: color, size: 24),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isHighlighted = chatRoom.unreadCount > 0;

    final content = ListTile(
      onTap: () => onTapped(chatRoom.roomId),
      contentPadding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing16, vertical: AppSpacing.height8),
      leading: _buildAvatar(context),
      title: Text(
        chatRoom.teamName,
        style: TextStyle(
          fontSize: AppSpacing.fontSize16,
          fontWeight: FontWeight.bold,
          color: context.colors.textPrimary,
        ),
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(top: AppSpacing.height4),
        child: Text(
          chatRoom.lastMessage != null
              ? '${chatRoom.lastMessageSenderName ?? ''}: ${chatRoom.lastMessage}'
              : _noMessagesLabel,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: AppSpacing.fontSize14,
            color: context.colors.textSecondary,
          ),
        ),
      ),
      trailing: SizedBox(
        width: _trailingWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (chatRoom.lastMessageAt != null)
              Text(
                _formatMessageTime(chatRoom.lastMessageAt),
                style: TextStyle(
                  fontSize: AppSpacing.fontSize12,
                  fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
                  color: isHighlighted ? context.colors.textPrimary : context.colors.textHint,
                ),
              ),
            SizedBox(height: AppSpacing.height6),
            if (chatRoom.unreadCount > 0)
              Container(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing8, vertical: AppSpacing.height4),
                decoration: BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  chatRoom.unreadCount > 99 ? _badgeOverflow : '${chatRoom.unreadCount}',
                  style: TextStyle(
                    fontSize: AppSpacing.fontSize11,
                    fontWeight: FontWeight.bold,
                    color: context.colors.surface,
                  ),
                ),
              ),
          ],
        ),
      ),
    );

    if (isHighlighted) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: AppSpacing.spacing16, vertical: AppSpacing.height4),
        decoration: BoxDecoration(
          color: context.colors.primaryLight,
          borderRadius: BorderRadius.circular(AppSpacing.radius16),
        ),
        child: content,
      );
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing16),
          child: content,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing32),
          child: Divider(
            height: 1,
            thickness: 0.5,
            color: context.colors.divider,
          ),
        ),
      ],
    );
  }
}
