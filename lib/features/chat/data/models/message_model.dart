import 'package:bridge_x/features/chat/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.messageId,
    required super.teamId,
    required super.senderId,
    required super.senderName,
    required super.content,
    super.createdAt,
    super.status = MessageStatus.sent,
    required super.localId,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      messageId: json['message_id'] as String,
      teamId: json['team_id'] as String,
      senderId: json['sender_id'] as String,
      senderName: json['sender_name'] as String? ?? '',
      content: json['content'] as String,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      status: MessageStatus.sent,
      localId: json['message_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message_id': messageId,
      'team_id': teamId,
      'sender_id': senderId,
      'sender_name': senderName,
      'content': content,
      'created_at': createdAt?.toIso8601String(),
    };
  }

}
