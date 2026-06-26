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
  final List<ChatRoomEntity> rooms;
  final bool isSearching;
  final String searchQuery;

  const ChatListLoaded({
    required this.rooms,
    this.isSearching = false,
    this.searchQuery = '',
  });

  ChatListLoaded copyWith({
    List<ChatRoomEntity>? rooms,
    bool? isSearching,
    String? searchQuery,
  }) {
    return ChatListLoaded(
      rooms: rooms ?? this.rooms,
      isSearching: isSearching ?? this.isSearching,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object> get props => [rooms, isSearching, searchQuery];
}

class ChatListEmpty extends ChatListState {}

class ChatListSearchEmpty extends ChatListState {}

class ChatListError extends ChatListState {
  final String message;

  const ChatListError({required this.message});

  @override
  List<Object> get props => [message];
}
