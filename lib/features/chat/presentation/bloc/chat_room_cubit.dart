import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bridge_x/core/services/logger_service.dart';
import 'package:bridge_x/features/chat/domain/entities/message_entity.dart';
import 'package:bridge_x/features/chat/domain/usecases/delete_message_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/edit_message_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/get_messages_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/mark_message_read_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/mark_messages_delivered_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/reset_unread_count_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/watch_messages_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/watch_room_membership_usecase.dart';
import 'package:bridge_x/features/chat/presentation/bloc/chat_room_state.dart';
import 'package:flutter/material.dart';

class ChatRoomCubit extends Cubit<ChatRoomState> with WidgetsBindingObserver {
  final String roomId;
  final int userId;
  final GetMessages getMessagesUseCase;
  final ResetUnreadCount resetUnreadCountUseCase;
  final SendMessage sendMessageUseCase;
  final WatchMessages watchMessagesUseCase;
  final EditMessage editMessageUseCase;
  final DeleteMessage deleteMessageUseCase;
  final MarkMessageRead markMessageReadUseCase;
  final MarkMessagesDelivered markMessagesDeliveredUseCase;
  final WatchRoomMembership watchRoomMembershipUseCase;

  StreamSubscription? _messagesSubscription;
  StreamSubscription? _membershipSubscription;
  bool _initialized = false;
  bool _hasMore = true;
  final Set<String> _knownMessageIds = {};
  final List<MessageEntity> _realtimeBuffer = [];
  static int _localCounter = 0;
  static const int _maxMessages = 500;

  ChatRoomCubit({
    required this.roomId,
    required this.userId,
    required this.getMessagesUseCase,
    required this.resetUnreadCountUseCase,
    required this.sendMessageUseCase,
    required this.watchMessagesUseCase,
    required this.editMessageUseCase,
    required this.deleteMessageUseCase,
    required this.markMessageReadUseCase,
    required this.markMessagesDeliveredUseCase,
    required this.watchRoomMembershipUseCase,
  }) : super(ChatRoomInitial());

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

    emit(ChatRoomLoading());

    await resetUnreadCountUseCase(ResetUnreadCountParams(roomId: roomId, userId: userId));
    await markMessagesDeliveredUseCase(MarkMessagesDeliveredParams(roomId: roomId, userId: userId));
    await loadMessages();
    _subscribeToRealtimeUpdates();
    _subscribeToMembershipUpdates();
  }

  Future<void> loadMessages() async {
    final result = await getMessagesUseCase(GetMessagesParams(
      roomId: roomId,
      userId: userId,
    ));

    result.fold(
      (failure) => emit(ChatRoomError(message: failure.message)),
      (messages) {
        _hasMore = messages.length >= 20;
        _knownMessageIds.addAll(messages.map((m) => m.messageId).where((id) => id.isNotEmpty));
        emit(ChatRoomLoaded(messages: messages, hasMore: _hasMore));
        _flushRealtimeBuffer();
      },
    );
  }

  void _flushRealtimeBuffer() {
    if (_realtimeBuffer.isEmpty) return;
    final currentState = state;
    if (currentState is! ChatRoomLoaded) return;

    final newMessages = <MessageEntity>[];
    for (final msg in _realtimeBuffer) {
      if (!_knownMessageIds.contains(msg.messageId)) {
        _knownMessageIds.add(msg.messageId);
        newMessages.add(msg);
      }
    }
    _realtimeBuffer.clear();

    if (newMessages.isEmpty) return;
    final updated = [...newMessages, ...currentState.messages];
    emit(currentState.copyWith(messages: _trimMessages(updated)));
  }

  List<MessageEntity> _trimMessages(List<MessageEntity> messages) {
    if (messages.length <= _maxMessages) return messages;
    final removed = messages.sublist(_maxMessages);
    for (final msg in removed) {
      _knownMessageIds.remove(msg.messageId);
    }
    return messages.sublist(0, _maxMessages);
  }

  Future<void> loadMoreMessages() async {
    if (!_hasMore) return;
    final currentState = state;
    if (currentState is! ChatRoomLoaded || currentState.loadingMore) return;

    emit(currentState.copyWith(loadingMore: true));

    final oldestMessage = currentState.messages.last;
    final cursor = oldestMessage.createdAt?.toIso8601String();

    final result = await getMessagesUseCase(GetMessagesParams(
      roomId: roomId,
      userId: userId,
      cursor: cursor,
    ));

    result.fold(
      (failure) => emit(currentState.copyWith(loadingMore: false)),
      (olderMessages) {
        _hasMore = olderMessages.length >= 20;
        _knownMessageIds.addAll(olderMessages.map((m) => m.messageId).where((id) => id.isNotEmpty));
        emit(ChatRoomLoaded(
          messages: _trimMessages([...currentState.messages, ...olderMessages]),
          hasMore: _hasMore,
          loadingMore: false,
        ));
      },
    );
  }

  void sendMessage(String content) {
    if (content.trim().isEmpty) return;
    if (content.trim().length > 2000) return;

    _localCounter++;
    final localId = '${DateTime.now().microsecondsSinceEpoch}_$_localCounter';
    final optimisticMessage = MessageEntity(
      messageId: '',
      roomId: roomId,
      senderId: userId,
      senderName: '',
      content: content.trim(),
      createdAt: DateTime.now(),
      sendStatus: MessageSendStatus.sending,
      localId: localId,
    );

    final currentState = state;
    if (currentState is ChatRoomLoaded) {
      emit(currentState.copyWith(
        messages: [optimisticMessage, ...currentState.messages],
        sendingMessage: true,
      ));
    } else {
      emit(ChatRoomLoaded(messages: [optimisticMessage], hasMore: false, sendingMessage: true));
    }

    _sendToServer(content.trim(), localId);
  }

  Future<void> _sendToServer(String content, String localId) async {
    final result = await sendMessageUseCase(SendMessageParams(
      roomId: roomId,
      senderId: userId,
      content: content,
    ));

    if (isClosed) return;
    final currentState = state;
    if (currentState is! ChatRoomLoaded) return;

    result.fold(
      (failure) {
        final updatedMessages = currentState.messages.map((m) {
          return m.localId == localId ? m.copyWith(sendStatus: MessageSendStatus.failed) : m;
        }).toList();
        emit(currentState.copyWith(messages: updatedMessages, sendingMessage: false));
      },
      (sentMessage) {
        final updatedMessages = currentState.messages.map((m) {
          return m.localId == localId
              ? MessageEntity(
                  messageId: sentMessage.messageId,
                  roomId: sentMessage.roomId,
                  senderId: sentMessage.senderId,
                  senderName: sentMessage.senderName,
                  content: sentMessage.content,
                  createdAt: sentMessage.createdAt,
                  isEdited: sentMessage.isEdited,
                  isDeleted: sentMessage.isDeleted,
                  myStatus: sentMessage.myStatus,
                  sendStatus: MessageSendStatus.sent,
                  localId: localId,
                )
              : m;
        }).toList();
        _knownMessageIds.add(sentMessage.messageId);
        emit(currentState.copyWith(messages: updatedMessages, sendingMessage: false));
      },
    );
  }

  Future<void> retrySendMessage(String localId) async {
    final currentState = state;
    if (currentState is! ChatRoomLoaded) return;

    final failedMessage = currentState.messages.cast<MessageEntity?>().firstWhere(
      (m) => m!.localId == localId,
      orElse: () => null,
    );

    if (failedMessage == null) return;

    final updatedMessages = currentState.messages.map((m) {
      return m.localId == localId ? m.copyWith(sendStatus: MessageSendStatus.sending) : m;
    }).toList();
    emit(currentState.copyWith(messages: updatedMessages));

    await _sendToServer(failedMessage.content, localId);
  }

  Future<void> editMessage(String messageId, String newContent) async {
    if (newContent.trim().isEmpty || newContent.trim().length > 2000) return;

    final result = await editMessageUseCase(EditMessageParams(messageId: messageId, newContent: newContent));
    result.fold(
      (failure) => LoggerService.error('Failed to edit message: ${failure.message}', tag: 'ChatRoomCubit'),
      (_) => LoggerService.debug('Message edited: $messageId', tag: 'ChatRoomCubit'),
    );
  }

  Future<void> deleteMessage(String messageId) async {
    final result = await deleteMessageUseCase(DeleteMessageParams(messageId: messageId));
    result.fold(
      (failure) => LoggerService.error('Failed to delete message: ${failure.message}', tag: 'ChatRoomCubit'),
      (_) {
        LoggerService.debug('Message deleted: $messageId', tag: 'ChatRoomCubit');
        if (state is ChatRoomLoaded) {
          final currentMessages = (state as ChatRoomLoaded).messages;
          final updatedMessages = currentMessages.map((m) {
            return m.messageId == messageId
                ? m.copyWith(isDeleted: true, content: '')
                : m;
          }).toList();
          emit((state as ChatRoomLoaded).copyWith(messages: updatedMessages));
        }
      },
    );
  }

  void _subscribeToRealtimeUpdates() {
    _messagesSubscription?.cancel();
    _messagesSubscription = watchMessagesUseCase(
      WatchMessagesParams(roomId: roomId, userId: userId),
    ).listen(
      (result) {
        if (isClosed) return;

        result.fold(
          (failure) => LoggerService.error('Realtime message error: ${failure.message}', tag: 'ChatRoomCubit'),
          (message) {
            if (_knownMessageIds.contains(message.messageId)) return;
            if (state is! ChatRoomLoaded) {
              _realtimeBuffer.add(message);
              return;
            }
            _onRealtimeMessage(message);
          },
        );
      },
      onError: (error) {
        LoggerService.error('Messages realtime error', exception: error, tag: 'ChatRoomCubit');
      },
    );
  }

  void _onRealtimeMessage(MessageEntity message) {
    if (isClosed) return;
    if (_knownMessageIds.contains(message.messageId)) return;

    final currentState = state;
    if (currentState is! ChatRoomLoaded) return;

    _knownMessageIds.add(message.messageId);

    emit(currentState.copyWith(messages: _trimMessages([message, ...currentState.messages])));

    resetUnreadCountUseCase(ResetUnreadCountParams(roomId: roomId, userId: userId)).then((result) {
      result.fold(
        (failure) => LoggerService.warning('Failed to reset unread count: ${failure.message}', tag: 'ChatRoomCubit'),
        (_) {},
      );
    });
  }

  void _subscribeToMembershipUpdates() {
    _membershipSubscription?.cancel();
    _membershipSubscription = watchRoomMembershipUseCase(
      WatchRoomMembershipParams(roomId: roomId, userId: userId),
    ).listen(
      (result) {
        if (isClosed) return;

        result.fold(
          (failure) => LoggerService.error('Membership error: ${failure.message}', tag: 'ChatRoomCubit'),
          (_) {
            if (isClosed) return;
            emit(ChatRoomRemoved(reason: 'You have been removed from this chat room.'));
          },
        );
      },
      onError: (error) {
        LoggerService.error('Membership realtime error', exception: error, tag: 'ChatRoomCubit');
      },
    );
  }

  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    _messagesSubscription?.cancel();
    _membershipSubscription?.cancel();
    return super.close();
  }
}
