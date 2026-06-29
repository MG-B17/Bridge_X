import 'package:bridge_x/features/chat/domain/entities/message_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ChatRoomState extends Equatable {
  const ChatRoomState();

  @override
  List<Object?> get props => [];
}

class ChatRoomInitial extends ChatRoomState {}

class ChatRoomLoading extends ChatRoomState {}

class ChatRoomLoaded extends ChatRoomState {
  final List<MessageEntity> messages;
  final bool hasMore;
  final bool loadingMore;
  final bool sendingMessage;

  const ChatRoomLoaded({
    required this.messages,
    this.hasMore = true,
    this.loadingMore = false,
    this.sendingMessage = false,
  });

  ChatRoomLoaded copyWith({
    List<MessageEntity>? messages,
    bool? hasMore,
    bool? loadingMore,
    bool? sendingMessage,
  }) {
    return ChatRoomLoaded(
      messages: messages ?? this.messages,
      hasMore: hasMore ?? this.hasMore,
      loadingMore: loadingMore ?? this.loadingMore,
      sendingMessage: sendingMessage ?? this.sendingMessage,
    );
  }

  @override
  List<Object?> get props => [messages, hasMore, loadingMore, sendingMessage];
}

class ChatRoomError extends ChatRoomState {
  final String message;

  const ChatRoomError({required this.message});

  @override
  List<Object?> get props => [message];
}
