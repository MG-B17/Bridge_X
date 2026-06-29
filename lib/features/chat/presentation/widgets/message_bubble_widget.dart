import 'package:flutter/material.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_colors.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/features/chat/domain/entities/message_entity.dart';
import 'package:bridge_x/features/chat/presentation/constants/chat_avatar_colors.dart';
import 'package:intl/intl.dart';

class MessageBubbleWidget extends StatelessWidget {
  final MessageEntity message;
  final bool isCurrentUser;

  const MessageBubbleWidget({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  static const _youLabel = 'You';
  static final _timeFormat = DateFormat('h:mm a');

  String? _parseFenceLanguage(String content) {
    if (!content.contains('```')) return null;
    final parts = content.split('```');
    if (parts.length < 3) return null;
    final fence = parts[1].trim();
    final lang = fence.split('\n').first.trim();
    return lang.isNotEmpty ? lang : null;
  }

  String? _extractCodeContent(String content) {
    if (!content.contains('```')) return null;
    final parts = content.split('```');
    if (parts.length < 3) return null;
    final fence = parts[1].trim();
    final code = fence.contains('\n') ? fence.substring(fence.indexOf('\n')).trim() : '';
    return code.isNotEmpty ? code : null;
  }

  String _extractTextContent(String content) {
    if (!content.contains('```')) return content;
    final parts = content.split('```');
    if (parts.length < 3) return content;
    return parts.sublist(2).join('').trim();
  }

  List<TextSpan> _highlightCode(String code) {
    final spans = <TextSpan>[];
    final exp = RegExp(
      r'(export|const|return|if|false|true)|'
      r'(\b\w+Session|\bvalidatesSession|\bverify|\bnow|\bjwt|\bDate)|'
      r'(\b\d+\b)|'
      r'(".*?"|' r"'.*?')",
    );

    var lastIndex = 0;
    for (final match in exp.allMatches(code)) {
      if (match.start > lastIndex) {
        spans.add(TextSpan(text: code.substring(lastIndex, match.start)));
      }
      final text = match.group(0)!;
      if (match.group(1) != null) {
        spans.add(TextSpan(text: text, style: const TextStyle(color: AppColors.indigo, fontWeight: FontWeight.bold)));
      } else if (match.group(2) != null) {
        spans.add(TextSpan(text: text, style: const TextStyle(color: AppColors.amber)));
      } else if (match.group(3) != null) {
        spans.add(TextSpan(text: text, style: const TextStyle(color: AppColors.success)));
      } else {
        spans.add(TextSpan(text: text, style: const TextStyle(color: AppColors.teal)));
      }
      lastIndex = match.end;
    }

    if (lastIndex < code.length) {
      spans.add(TextSpan(text: code.substring(lastIndex)));
    }
    return spans;
  }

  Widget _buildCodeBlock(BuildContext context, String codeText) {
    final language = _parseFenceLanguage(message.content);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.navyBlue,
        borderRadius: BorderRadius.circular(AppSpacing.radius12),
      ),
      padding: EdgeInsets.all(AppSpacing.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (language != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  language,
                  style: TextStyle(
                    color: context.colors.textSecondary,
                    fontStyle: FontStyle.italic,
                    fontSize: AppSpacing.fontSize12,
                  ),
                ),
              ],
            ),
          SizedBox(height: language != null ? AppSpacing.height12 : 0),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                height: 1.5,
                color: AppColors.lightGray,
              ),
              children: _highlightCode(codeText),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(String senderName) {
    final hash = senderName.hashCode;
    final color = chatAvatarPalette[hash.abs() % chatAvatarPalette.length];
    return CircleAvatar(
      radius: AppSpacing.radius12,
      backgroundColor: color.withValues(alpha: 0.15),
      child: Text(
        senderName.isNotEmpty ? senderName[0].toUpperCase() : '?',
        style: TextStyle(
          color: color,
          fontSize: AppSpacing.fontSize10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasCode = message.content.contains('```');
    final codeBlockContent = hasCode ? _extractCodeContent(message.content) : null;
    final displayContent = hasCode ? _extractTextContent(message.content) : message.content;

    final formattedTime = message.createdAt != null
        ? _timeFormat.format(message.createdAt!)
        : '';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing20, vertical: AppSpacing.height8),
      child: Column(
        crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: AppSpacing.height4),
            child: Text(
              isCurrentUser ? _youLabel : message.senderName,
              style: TextStyle(
                color: context.colors.textSecondary,
                fontWeight: FontWeight.bold,
                fontSize: AppSpacing.fontSize12,
              ),
            ),
          ),

          Row(
            mainAxisAlignment: isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (message.sendStatus == MessageSendStatus.failed)
                Padding(
                  padding: EdgeInsets.only(right: AppSpacing.spacing6),
                  child: Icon(Icons.error_outline, color: context.colors.error, size: AppSpacing.fontSize16),
                ),
              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: context.screenWidth * 0.8,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing16, vertical: AppSpacing.height12),
                  decoration: BoxDecoration(
                    color: isCurrentUser ? context.colors.primary : context.colors.surface,
                    borderRadius: BorderRadius.circular(AppSpacing.radius16),
                    border: isCurrentUser
                        ? null
                        : Border.all(color: context.colors.divider, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (codeBlockContent != null)
                        _buildCodeBlock(context, codeBlockContent),
                      if (displayContent.isNotEmpty)
                        Text(
                          displayContent,
                          style: TextStyle(
                            color: isCurrentUser ? context.colors.surface : context.colors.textPrimary,
                            fontSize: AppSpacing.fontSize15,
                            height: 1.4,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: AppSpacing.height6),

          Row(
            mainAxisAlignment: isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isCurrentUser) ...[
                _buildAvatar(message.senderName),
                SizedBox(width: AppSpacing.spacing6),
              ],
              Text(
                formattedTime,
                style: TextStyle(
                  color: context.colors.textHint,
                  fontSize: AppSpacing.fontSize11,
                ),
              ),
              if (isCurrentUser) ...[
                SizedBox(width: AppSpacing.spacing4),
                Icon(
                  message.sendStatus == MessageSendStatus.sending
                      ? Icons.access_time_rounded
                      : message.sendStatus == MessageSendStatus.failed
                          ? Icons.error_outline_rounded
                          : Icons.done_rounded,
                  size: AppSpacing.fontSize12,
                  color: message.sendStatus == MessageSendStatus.sent
                      ? context.colors.textHint
                      : message.sendStatus == MessageSendStatus.failed
                          ? context.colors.error
                          : context.colors.textHint,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
