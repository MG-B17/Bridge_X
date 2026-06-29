import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bridge_x/core/services/logger_service.dart';
import 'package:bridge_x/features/chat/domain/entities/chat_room_entity.dart';
import 'package:bridge_x/features/chat/domain/usecases/delete_chat_room_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/change_leader_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/get_chat_rooms_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/reset_unread_count_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/search_chat_rooms_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/subscribe_to_chat_rooms_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/watch_connection_status_usecase.dart';
import 'package:bridge_x/features/chat/presentation/bloc/chat_list_state.dart';
import 'package:flutter/material.dart';

class ChatListCubit extends Cubit<ChatListState> with WidgetsBindingObserver {
  final GetChatRooms getChatRoomsUseCase;
  final SearchChatRooms searchChatRoomsUseCase;
  final SubscribeToChatRooms subscribeToChatRoomsUseCase;
  final ResetUnreadCount resetUnreadCountUseCase;
  final DeleteChatRoom deleteChatRoomUseCase;
  final ChangeLeader changeLeaderUseCase;
  final WatchConnectionStatus watchConnectionStatusUseCase;

  StreamSubscription? _chatRoomsSubscription;
  StreamSubscription? _connectionSubscription;
  Timer? _debounce;
  int? _currentUserId;
  bool _initialized = false;

  ChatListCubit({
    required this.getChatRoomsUseCase,
    required this.searchChatRoomsUseCase,
    required this.subscribeToChatRoomsUseCase,
    required this.resetUnreadCountUseCase,
    required this.deleteChatRoomUseCase,
    required this.changeLeaderUseCase,
    required this.watchConnectionStatusUseCase,
  }) : super(ChatListInitial());

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _chatRoomsSubscription?.pause();
    } else if (state == AppLifecycleState.resumed) {
      _chatRoomsSubscription?.resume();
    }
  }

  Future<void> init(int userId) async {
    if (_currentUserId == userId && _initialized) return;
    _currentUserId = userId;
    if (!_initialized) {
      _initialized = true;
      WidgetsBinding.instance.addObserver(this);
    }
    await loadChatRooms();
    _subscribeToRealtimeUpdates();
    _subscribeToConnectionStatus();
  }

  Future<void> loadChatRooms() async {
    if (_currentUserId == null) return;

    emit(ChatListLoading());

    final result = await getChatRoomsUseCase(GetChatRoomsParams(userId: _currentUserId!));
    result.fold(
      (failure) => emit(ChatListError(message: failure.message)),
      (rooms) {
        if (rooms.isEmpty) {
          emit(ChatListEmpty());
        } else {
          emit(ChatListLoaded(rooms: rooms));
        }
      },
    );
  }

  void searchChatRooms(String query) {
    if (_currentUserId == null) return;

    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () async {
      if (query.isEmpty) {
        await loadChatRooms();
        return;
      }

      final result = await searchChatRoomsUseCase(
        SearchChatRoomsParams(userId: _currentUserId!, query: query),
      );

      result.fold(
        (failure) => emit(ChatListError(message: failure.message)),
        (rooms) {
          if (rooms.isEmpty) {
            emit(ChatListSearchEmpty());
          } else {
            emit(ChatListLoaded(rooms: rooms, isSearching: true, searchQuery: query));
          }
        },
      );
    });
  }

  Future<void> onChatRoomOpened(String roomId) async {
    if (_currentUserId == null) return;

    final result = await resetUnreadCountUseCase(
      ResetUnreadCountParams(roomId: roomId, userId: _currentUserId!),
    );
    result.fold(
      (failure) => LoggerService.warning('Failed to reset unread count: ${failure.message}', tag: 'ChatListCubit'),
      (_) => LoggerService.debug('Unread count reset for room: $roomId', tag: 'ChatListCubit'),
    );
  }

  Future<void> deleteRoom(String roomId) async {
    final result = await deleteChatRoomUseCase(DeleteChatRoomParams(roomId: roomId));
    result.fold(
      (failure) => LoggerService.error('Failed to delete room: ${failure.message}', tag: 'ChatListCubit'),
      (_) {
        LoggerService.debug('Room deleted: $roomId', tag: 'ChatListCubit');
        loadChatRooms();
      },
    );
  }

  Future<void> changeLeader(String roomId, int newLeaderId) async {
    if (_currentUserId == null) return;

    final result = await changeLeaderUseCase(
      ChangeLeaderParams(roomId: roomId, newLeaderId: newLeaderId, oldLeaderId: _currentUserId!),
    );
    result.fold(
      (failure) => LoggerService.error('Failed to change leader: ${failure.message}', tag: 'ChatListCubit'),
      (_) => LoggerService.debug('Leader changed for room: $roomId', tag: 'ChatListCubit'),
    );
  }

  void _subscribeToRealtimeUpdates() {
    if (_currentUserId == null) return;

    _chatRoomsSubscription?.cancel();
    _chatRoomsSubscription = subscribeToChatRoomsUseCase(
      SubscribeToChatRoomsParams(userId: _currentUserId!),
    ).listen(
      (result) {
        if (isClosed) return;
        result.fold(
          (failure) => LoggerService.error('Realtime error: ${failure.message}', tag: 'ChatListCubit'),
          (rooms) {
            if (isClosed) return;

            final currentState = state;
            if (currentState is ChatListLoaded) {
              if (currentState.isSearching) return;
              if (_areListsEqual(currentState.rooms, rooms)) return;
            }

            if (rooms.isEmpty) {
              emit(ChatListEmpty());
            } else {
              emit(ChatListLoaded(rooms: rooms));
            }
          },
        );
      },
      onError: (error) {
        LoggerService.error('Realtime subscription error', exception: error, tag: 'ChatListCubit');
      },
    );
  }

  void _subscribeToConnectionStatus() {
    _connectionSubscription?.cancel();
    _connectionSubscription = watchConnectionStatusUseCase().listen((connected) {
      if (isClosed) return;
      final currentState = state;
      if (currentState is ChatListLoaded) {
        if (currentState.connected != connected) {
          emit(currentState.copyWith(connected: connected));
        }
      }
    });
  }

  bool _areListsEqual(List<ChatRoomEntity> a, List<ChatRoomEntity> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i].roomId != b[i].roomId) return false;
      if (a[i].lastMessageAt != b[i].lastMessageAt) return false;
      if (a[i].unreadCount != b[i].unreadCount) return false;
      if (a[i].lastMessage != b[i].lastMessage) return false;
    }
    return true;
  }

  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    _chatRoomsSubscription?.cancel();
    _connectionSubscription?.cancel();
    _debounce?.cancel();
    return super.close();
  }
}
