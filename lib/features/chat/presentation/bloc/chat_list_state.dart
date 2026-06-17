import 'package:equatable/equatable.dart';
import 'package:bridge_x/features/chat/domain/entities/chat_room_entity.dart';

abstract class ChatListState extends Equatable {
  const ChatListState();

  @override
  List<Object> get props => [];
}

class ChatListInitial extends ChatListState {}

class ChatListLoading extends ChatListState {}

class ChatListLoaded extends ChatListState {
  final List<ChatRoomEntity> chatRooms;

  const ChatListLoaded({required this.chatRooms});

  @override
  List<Object> get props => [chatRooms];
}

class ChatListSearching extends ChatListState {
  final List<ChatRoomEntity> chatRooms;

  const ChatListSearching({required this.chatRooms});

  @override
  List<Object> get props => [chatRooms];
}

class ChatListEmpty extends ChatListState {}

class ChatListSearchEmpty extends ChatListState {}

class ChatListError extends ChatListState {
  final String message;

  const ChatListError({required this.message});

  @override
  List<Object> get props => [message];
}
