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
  final bool sending;

  const ChatRoomLoaded({
    required this.messages,
    this.hasMore = true,
    this.loadingMore = false,
    this.sending = false,
  });

  ChatRoomLoaded copyWith({
    List<MessageEntity>? messages,
    bool? hasMore,
    bool? loadingMore,
    bool? sending,
  }) {
    return ChatRoomLoaded(
      messages: messages ?? this.messages,
      hasMore: hasMore ?? this.hasMore,
      loadingMore: loadingMore ?? this.loadingMore,
      sending: sending ?? this.sending,
    );
  }

  @override
  List<Object?> get props => [messages, hasMore, loadingMore, sending];
}

class ChatRoomError extends ChatRoomState {
  final String message;

  const ChatRoomError({required this.message});

  @override
  List<Object?> get props => [message];
}
