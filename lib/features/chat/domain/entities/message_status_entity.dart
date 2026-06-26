import 'package:equatable/equatable.dart';
import 'message_entity.dart';

class MessageStatusEntity extends Equatable {
  final String messageId;
  final int userId;
  final MessageDeliveryStatus status;
  final DateTime? updatedAt;

  const MessageStatusEntity({
    required this.messageId,
    required this.userId,
    required this.status,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [messageId, userId, status, updatedAt];
}
