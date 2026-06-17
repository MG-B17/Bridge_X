import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bridge_x/core/constant/app_keys.dart';
import 'package:bridge_x/core/services/logger_service.dart';
import 'package:bridge_x/core/services/secure_storage_service.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/usecases/get_chat_rooms_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/reconcile_membership_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/reset_unread_count_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/search_chat_rooms_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/subscribe_to_chat_rooms_usecase.dart';
import 'package:bridge_x/features/chat/presentation/bloc/chat_list_state.dart';
import 'package:flutter/material.dart';

class ChatListCubit extends Cubit<ChatListState> with WidgetsBindingObserver {
  final GetChatRooms getChatRoomsUseCase;
  final SearchChatRooms searchChatRoomsUseCase;
  final SubscribeToChatRooms subscribeToChatRoomsUseCase;
  final ResetUnreadCount resetUnreadCountUseCase;
  final ReconcileMembership reconcileMembershipUseCase;
  final SecureStorageService secureStorageService;

  StreamSubscription? _chatRoomsSubscription;
  Timer? _debounce;
  bool _initialized = false;

  ChatListCubit({
    required this.getChatRoomsUseCase,
    required this.searchChatRoomsUseCase,
    required this.subscribeToChatRoomsUseCase,
    required this.resetUnreadCountUseCase,
    required this.reconcileMembershipUseCase,
    required this.secureStorageService,
  }) : super(ChatListInitial());

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _chatRoomsSubscription?.pause();
    } else if (state == AppLifecycleState.resumed) {
      _chatRoomsSubscription?.resume();
    }
  }

  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;
    WidgetsBinding.instance.addObserver(this);

    final userId = await secureStorageService.read(key: AppKeys.userId);
    if (userId == null || userId.isEmpty) {
      LoggerService.warning('init skipped: no user ID found', tag: 'ChatListCubit');
      emit(ChatListEmpty());
      return;
    }

    try {
      await reconcileMembership();
    } catch (e) {
      LoggerService.error('reconcileMembership threw unexpectedly', exception: e, tag: 'ChatListCubit');
    }

    await loadChatRooms();
    _subscribeToRealtimeUpdates();
  }

  Future<void> reconcileMembership() async {
    final result = await reconcileMembershipUseCase(NoParams());
    result.fold(
      (failure) => LoggerService.warning('Reconciliation failed: ${failure.message}', tag: 'ChatListCubit'),
      (_) => LoggerService.debug('Reconciliation successful', tag: 'ChatListCubit'),
    );
  }

  Future<void> loadChatRooms() async {
    emit(ChatListLoading());
    final result = await getChatRoomsUseCase(NoParams());
    result.fold(
      (failure) => emit(ChatListError(message: failure.message)),
      (chatRooms) {
        if (chatRooms.isEmpty) {
          emit(ChatListEmpty());
        } else {
          emit(ChatListLoaded(chatRooms: chatRooms));
        }
      },
    );
  }

  void searchChatRooms(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _chatRoomsSubscription?.pause();
    _debounce = Timer(const Duration(milliseconds: 400), () async {
      if (query.isEmpty) {
        _chatRoomsSubscription?.resume();
        await loadChatRooms();
        return;
      }
      emit(ChatListLoading());
      final result = await searchChatRoomsUseCase(SearchChatRoomsParams(query: query));
      _chatRoomsSubscription?.resume();
      result.fold(
        (failure) => emit(ChatListError(message: failure.message)),
        (chatRooms) {
          if (chatRooms.isEmpty) {
            emit(ChatListSearchEmpty());
          } else {
            emit(ChatListSearching(chatRooms: chatRooms));
          }
        },
      );
    });
  }

  void _subscribeToRealtimeUpdates() {
    _chatRoomsSubscription?.cancel();
    _chatRoomsSubscription = subscribeToChatRoomsUseCase(NoParams()).listen(
      (chatRooms) {
        if (!isClosed) {
          if (chatRooms.isEmpty) {
            emit(ChatListEmpty());
          } else {
            emit(ChatListLoaded(chatRooms: chatRooms));
          }
        }
      },
      onError: (error) {
        LoggerService.error('Realtime subscription error', exception: error, tag: 'ChatListCubit');
      },
    );
  }

  Future<void> onChatRoomOpened(String teamId) async {
    final result = await resetUnreadCountUseCase(ResetUnreadCountParams(teamId: teamId));
    result.fold(
      (failure) => LoggerService.warning('Failed to reset unread count: ${failure.message}', tag: 'ChatListCubit'),
      (_) => LoggerService.debug('Unread count reset for team: $teamId', tag: 'ChatListCubit'),
    );
  }

  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    _chatRoomsSubscription?.cancel();
    _debounce?.cancel();
    return super.close();
  }
}
