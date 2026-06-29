import 'package:bridge_x/features/chat/domain/entities/message_entity.dart';
import 'package:bridge_x/features/chat/domain/entities/message_status_entity.dart';

class MessageStatusModel extends MessageStatusEntity {
  const MessageStatusModel({
    required super.messageId,
    required super.userId,
    required super.status,
    super.updatedAt,
  });

  factory MessageStatusModel.fromJson(Map<String, dynamic> json) {
    final statusStr = json['status'] as String;
    final status = MessageDeliveryStatus.values.firstWhere(
      (e) => e.name == statusStr,
      orElse: () => MessageDeliveryStatus.sent,
    );

    return MessageStatusModel(
      messageId: json['message_id'] as String,
      userId: json['user_id'] as int,
      status: status,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message_id': messageId,
      'user_id': userId,
      'status': status.name,
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
