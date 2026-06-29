import 'package:equatable/equatable.dart';

enum MessageSendStatus { sending, sent, failed }
enum MessageDeliveryStatus { sent, delivered, read }

class MessageEntity extends Equatable {
  final String messageId;
  final String roomId;
  final int senderId;
  final String senderName;
  final String content;
  final bool isEdited;
  final bool isDeleted;
  final DateTime? createdAt;
  final MessageDeliveryStatus? myStatus;
  final MessageSendStatus sendStatus;
  final String localId;

  const MessageEntity({
    required this.messageId,
    required this.roomId,
    required this.senderId,
    required this.senderName,
    required this.content,
    this.isEdited = false,
    this.isDeleted = false,
    this.createdAt,
    this.myStatus,
    this.sendStatus = MessageSendStatus.sent,
    required this.localId,
  });

  MessageEntity copyWith({
    String? messageId,
    String? roomId,
    int? senderId,
    String? senderName,
    String? content,
    bool? isEdited,
    bool? isDeleted,
    DateTime? createdAt,
    MessageDeliveryStatus? myStatus,
    MessageSendStatus? sendStatus,
    String? localId,
  }) {
    return MessageEntity(
      messageId: messageId ?? this.messageId,
      roomId: roomId ?? this.roomId,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      content: content ?? this.content,
      isEdited: isEdited ?? this.isEdited,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      myStatus: myStatus ?? this.myStatus,
      sendStatus: sendStatus ?? this.sendStatus,
      localId: localId ?? this.localId,
    );
  }

  @override
  List<Object?> get props => [
    messageId,
    roomId,
    senderId,
    senderName,
    content,
    isEdited,
    isDeleted,
    createdAt,
    myStatus,
    sendStatus,
    localId,
  ];
}
