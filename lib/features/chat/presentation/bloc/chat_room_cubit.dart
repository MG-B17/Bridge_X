import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bridge_x/core/constant/app_keys.dart';
import 'package:bridge_x/core/services/logger_service.dart';
import 'package:bridge_x/core/services/secure_storage_service.dart';
import 'package:bridge_x/features/chat/domain/entities/message_entity.dart';
import 'package:bridge_x/features/chat/domain/usecases/get_messages_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/reset_unread_count_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/watch_messages_usecase.dart';
import 'package:bridge_x/features/chat/presentation/bloc/chat_room_state.dart';
import 'package:flutter/material.dart';

class ChatRoomCubit extends Cubit<ChatRoomState> with WidgetsBindingObserver {
  final String teamId;
  final GetMessages getMessagesUseCase;
  final ResetUnreadCount resetUnreadCountUseCase;
  final SendMessage sendMessageUseCase;
  final WatchMessages watchMessagesUseCase;
  final SecureStorageService secureStorageService;

  String currentUserId = '';
  String currentUserName = '';
  StreamSubscription? _messagesSubscription;
  bool _initialized = false;
  bool _hasMore = true;

  ChatRoomCubit({
    required this.teamId,
    required this.getMessagesUseCase,
    required this.resetUnreadCountUseCase,
    required this.sendMessageUseCase,
    required this.watchMessagesUseCase,
    required this.secureStorageService,
  }) : super(ChatRoomInitial());

  Set<String> get _knownMessageIds {
    if (state is ChatRoomLoaded) {
      return (state as ChatRoomLoaded)
          .messages
          .map((m) => m.messageId)
          .where((id) => id.isNotEmpty)
          .toSet();
    }
    return {};
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _messagesSubscription?.pause();
    } else if (state == AppLifecycleState.resumed) {
      _messagesSubscription?.resume();
    }
  }

  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;
    WidgetsBinding.instance.addObserver(this);

    final userId = await secureStorageService.read(key: AppKeys.userId);
    currentUserId = userId ?? '';
    final userName = await secureStorageService.read(key: AppKeys.userName);
    currentUserName = (userName != null && userName.isNotEmpty) ? userName : currentUserId;

    if (currentUserId.isEmpty) {
      LoggerService.warning('init skipped: no user ID found', tag: 'ChatRoomCubit');
      emit(ChatRoomError(message: 'User not found'));
      return;
    }

    emit(ChatRoomLoading());
    await resetUnreadCountUseCase(ResetUnreadCountParams(teamId: teamId));
    await loadMessages();
    _subscribeToRealtimeUpdates();
  }

  Future<void> loadMessages() async {
    final result = await getMessagesUseCase(GetMessagesParams(teamId: teamId));
    result.fold(
      (failure) => emit(ChatRoomError(message: failure.message)),
      (messages) {
        _hasMore = messages.length >= 20;
        emit(ChatRoomLoaded(messages: messages, hasMore: _hasMore));
      },
    );
  }

  Future<void> loadMoreMessages() async {
    if (!_hasMore) return;
    final currentState = state;
    if (currentState is! ChatRoomLoaded || currentState.loadingMore) return;

    emit(currentState.copyWith(loadingMore: true));

    final oldestMessage = currentState.messages.last;
    final lastCreatedAt = oldestMessage.createdAt?.toIso8601String();

    final result = await getMessagesUseCase(GetMessagesParams(
      teamId: teamId,
      lastCreatedAt: lastCreatedAt,
    ));
    result.fold(
      (failure) => emit(currentState.copyWith(loadingMore: false)),
      (olderMessages) {
        _hasMore = olderMessages.length >= 20;
        emit(ChatRoomLoaded(
          messages: [...currentState.messages, ...olderMessages],
          hasMore: _hasMore,
          loadingMore: false,
        ));
      },
    );
  }

  void sendMessage(String content) {
    if (content.trim().isEmpty) return;
    if (content.trim().length > 2000) return;

    final localId = DateTime.now().microsecondsSinceEpoch.toString();

    final optimisticMessage = MessageEntity(
      messageId: '',
      teamId: teamId,
      senderId: currentUserId,
      senderName: currentUserName,
      content: content.trim(),
      createdAt: DateTime.now(),
      status: MessageStatus.sending,
      localId: localId,
    );

    List<MessageEntity> updatedMessages;
    if (state is ChatRoomLoaded) {
      updatedMessages = [optimisticMessage, ...(state as ChatRoomLoaded).messages];
    } else {
      updatedMessages = [optimisticMessage];
    }

    emit(ChatRoomLoaded(messages: updatedMessages, hasMore: _hasMore, sending: true));

    _sendToServer(content.trim(), localId);
  }

  Future<void> _sendToServer(String content, String localId) async {
    final result = await sendMessageUseCase(SendMessageParams(teamId: teamId, content: content, senderName: currentUserName));
    result.fold(
      (failure) {
        if (state is ChatRoomLoaded) {
          final currentMessages = (state as ChatRoomLoaded).messages;
          final updatedMessages = currentMessages.map((m) {
            return m.localId == localId ? m.copyWith(status: MessageStatus.failed) : m;
          }).toList();
          emit(ChatRoomLoaded(messages: updatedMessages, hasMore: _hasMore, sending: false));
        }
      },
      (sentMessage) {
        if (!isClosed && state is ChatRoomLoaded) {
          final currentMessages = (state as ChatRoomLoaded).messages;
          final updatedMessages = currentMessages.map((m) {
            return m.localId == localId
                ? MessageEntity(
                    messageId: sentMessage.messageId,
                    teamId: sentMessage.teamId,
                    senderId: sentMessage.senderId,
                    senderName: sentMessage.senderName,
                    content: sentMessage.content,
                    createdAt: sentMessage.createdAt,
                    status: MessageStatus.sent,
                    localId: localId,
                  )
                : m;
          }).toList();
          emit(ChatRoomLoaded(messages: updatedMessages, hasMore: _hasMore, sending: false));
        }
      },
    );
  }

  void _subscribeToRealtimeUpdates() {
    _messagesSubscription?.cancel();
    _messagesSubscription = watchMessagesUseCase(WatchMessagesParams(teamId: teamId)).listen(
      (message) async {
        if (isClosed) return;
        if (_knownMessageIds.contains(message.messageId)) return;

        await resetUnreadCountUseCase(ResetUnreadCountParams(teamId: teamId));

        if (isClosed) return;
        if (state is ChatRoomLoaded) {
          final currentMessages = (state as ChatRoomLoaded).messages;
          emit(ChatRoomLoaded(
            messages: [message, ...currentMessages],
            hasMore: _hasMore,
          ));
        } else {
          emit(ChatRoomLoaded(messages: [message], hasMore: true));
        }
      },
      onError: (error) {
        LoggerService.error('Messages realtime subscription error', exception: error, tag: 'ChatRoomCubit');
      },
    );
  }

  @override
  Future<void> close() async {
    WidgetsBinding.instance.removeObserver(this);
    _messagesSubscription?.cancel();
    await resetUnreadCountUseCase(ResetUnreadCountParams(teamId: teamId));
    return super.close();
  }
}
