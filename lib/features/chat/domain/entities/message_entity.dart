import 'package:equatable/equatable.dart';

enum MessageStatus { sending, sent, failed }

class MessageEntity extends Equatable {
  final String messageId;
  final String teamId;
  final String senderId;
  final String senderName;
  final String content;
  final DateTime? createdAt;
  final MessageStatus status;
  final String localId;

  const MessageEntity({
    required this.messageId,
    required this.teamId,
    required this.senderId,
    required this.senderName,
    required this.content,
    this.createdAt,
    this.status = MessageStatus.sent,
    required this.localId,
  });

  MessageEntity copyWith({
    String? messageId,
    String? teamId,
    String? senderId,
    String? senderName,
    String? content,
    DateTime? createdAt,
    MessageStatus? status,
    String? localId,
  }) {
    return MessageEntity(
      messageId: messageId ?? this.messageId,
      teamId: teamId ?? this.teamId,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      localId: localId ?? this.localId,
    );
  }

  @override
  List<Object?> get props => [
        messageId,
        teamId,
        senderId,
        senderName,
        content,
        createdAt,
        status,
        localId,
      ];
}
