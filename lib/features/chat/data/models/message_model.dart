import 'package:bridge_x/features/chat/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.messageId,
    required super.roomId,
    required super.senderId,
    required super.senderName,
    required super.content,
    super.isEdited = false,
    super.isDeleted = false,
    super.createdAt,
    super.myStatus,
    super.sendStatus = MessageSendStatus.sent,
    required super.localId,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    MessageDeliveryStatus? myStatus;
    final statusStr = json['my_status'] as String?;
    if (statusStr != null) {
      myStatus = MessageDeliveryStatus.values.firstWhere(
        (e) => e.name == statusStr,
        orElse: () => MessageDeliveryStatus.sent,
      );
    }

    return MessageModel(
      messageId: json['message_id'] as String,
      roomId: json['room_id'] as String,
      senderId: json['sender_id'] as int,
      senderName: json['sender_name'] as String? ?? '',
      content: json['content'] as String,
      isEdited: json['is_edited'] as bool? ?? false,
      isDeleted: json['is_deleted'] as bool? ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      myStatus: myStatus,
      localId: json['message_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message_id': messageId,
      'room_id': roomId,
      'sender_id': senderId,
      'content': content,
      'is_edited': isEdited,
      'is_deleted': isDeleted,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
