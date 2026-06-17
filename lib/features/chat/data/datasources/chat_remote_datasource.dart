import 'dart:async';

import 'package:bridge_x/core/constant/app_keys.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/services/logger_service.dart';
import 'package:bridge_x/core/services/secure_storage_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bridge_x/features/chat/data/models/chat_room_model.dart';
import 'package:bridge_x/features/chat/data/models/message_model.dart';

abstract class ChatRemoteDataSource {
  Future<List<ChatRoomModel>> getChatRooms();
  Future<List<ChatRoomModel>> searchChatRooms(String query);
  Stream<List<ChatRoomModel>> subscribeToChatRooms();
  Future<void> resetUnreadCount(String teamId);
  Future<void> reconcileMembership();
  Future<void> createChatRoom({
    required String teamId,
    required String teamName,
    required String creatorId,
    required List<String> memberIds,
  });

  Future<List<MessageModel>> getMessages(String teamId, {String? lastCreatedAt, int limit = 20});
  Future<MessageModel> sendMessage(String teamId, String content, String senderName);
  Stream<MessageModel> watchMessages(String teamId);
  void dispose();
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final SupabaseClient supabaseClient;
  final SecureStorageService secureStorageService;
  RealtimeChannel? _realtimeChannel;
  final StreamController<List<ChatRoomModel>> _chatRoomsStreamController =
      StreamController<List<ChatRoomModel>>.broadcast();
  Timer? _realtimeDebounce;
  RealtimeChannel? _messagesChannel;
  final StreamController<MessageModel> _messagesStreamController =
      StreamController<MessageModel>.broadcast();
  bool _disposed = false;

  ChatRemoteDataSourceImpl({required this.supabaseClient, required this.secureStorageService});

  Future<String> _getCurrentUserId(String method) async {
    final userId = await secureStorageService.read(key: AppKeys.userId);
    if (userId == null || userId.isEmpty) {
      LoggerService.error('$method failed: no user ID stored', tag: 'ChatRemoteDataSource');
      throw ServerException('User not authenticated');
    }
    return userId;
  }

  @override
  Future<List<ChatRoomModel>> getChatRooms() async {
    final userId = await _getCurrentUserId('getChatRooms');

    final response = await supabaseClient
        .from('room_members')
        .select('*, chat_rooms!inner(team_id, team_name, last_message, last_message_sender_name, last_message_at)')
        .eq('user_id', userId)
        .order('last_message_at', referencedTable: 'chat_rooms', ascending: false);

    LoggerService.debug('getChatRooms returned ${response.length} rooms', tag: 'ChatRemoteDataSource');
    return response
        .map<ChatRoomModel>((json) => ChatRoomModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<ChatRoomModel>> searchChatRooms(String query) async {
    LoggerService.debug('searchChatRooms: query="$query"', tag: 'ChatRemoteDataSource');
    final userId = await _getCurrentUserId('searchChatRooms');

    final response = await supabaseClient
        .from('room_members')
        .select('*, chat_rooms!inner(team_id, team_name, last_message, last_message_sender_name, last_message_at)')
        .eq('user_id', userId)
        .ilike('chat_rooms.team_name', '%$query%')
        .order('last_message_at', referencedTable: 'chat_rooms', ascending: false);

    LoggerService.debug('searchChatRooms returned ${response.length} results', tag: 'ChatRemoteDataSource');
    return response
        .map<ChatRoomModel>((json) => ChatRoomModel.fromJson(json))
        .toList();
  }

  @override
  Stream<List<ChatRoomModel>> subscribeToChatRooms() {
    _getCurrentUserId('subscribeToChatRooms').then((userId) {
      if (_disposed) return;
      _realtimeChannel?.unsubscribe();
      _realtimeChannel = supabaseClient.channel('public:chat_updates');

      void refreshChatRooms() {
        _realtimeDebounce?.cancel();
        _realtimeDebounce = Timer(const Duration(milliseconds: 500), () {
          if (_disposed) return;
          getChatRooms().then((chatRooms) {
            if (!_disposed) _chatRoomsStreamController.add(chatRooms);
          }).catchError((error) {
            LoggerService.error('Failed to refresh chat rooms after realtime event', exception: error, tag: 'ChatRemoteDataSource');
            if (!_disposed) _chatRoomsStreamController.addError(error);
          });
        });
      }

      _realtimeChannel!.onPostgresChanges(
        event: PostgresChangeEvent.all,
        schema: 'public',
        table: 'room_members',
        filter: PostgresChangeFilter(
          column: 'user_id',
          value: userId,
          type: PostgresChangeFilterType.eq,
        ),
        callback: (payload) {
          LoggerService.debug('room_members change: ${payload.eventType}', tag: 'ChatRemoteDataSource');
          refreshChatRooms();
        },
      ).onPostgresChanges(
        event: PostgresChangeEvent.update,
        schema: 'public',
        table: 'chat_rooms',
        callback: (payload) {
          LoggerService.debug('chat_rooms update: ${payload.eventType}', tag: 'ChatRemoteDataSource');
          refreshChatRooms();
        },
      ).subscribe();

      LoggerService.debug('Subscribed to realtime channel: public:chat_updates', tag: 'ChatRemoteDataSource');
    }).catchError((error) {
      LoggerService.error('subscribeToChatRooms failed', exception: error, tag: 'ChatRemoteDataSource');
      _chatRoomsStreamController.addError(error);
    });

    return _chatRoomsStreamController.stream;
  }

  @override
  Future<void> resetUnreadCount(String teamId) async {
    LoggerService.debug('resetUnreadCount: teamId=$teamId', tag: 'ChatRemoteDataSource');
    final userId = await _getCurrentUserId('resetUnreadCount');
    await supabaseClient
        .from('room_members')
        .update({'unread_count': 0, 'last_read_at': DateTime.now().toUtc().toIso8601String()})
        .eq('team_id', teamId)
        .eq('user_id', userId);
  }

  @override
  Future<void> reconcileMembership() async {
    LoggerService.debug('reconcileMembership', tag: 'ChatRemoteDataSource');
    try {
      await supabaseClient.rpc('reconcile_membership');
    } catch (e) {
      LoggerService.warning('reconcileMembership skipped (RPC not found): $e', tag: 'ChatRemoteDataSource');
    }
  }

  @override
  Future<void> createChatRoom({
    required String teamId,
    required String teamName,
    required String creatorId,
    required List<String> memberIds,
  }) async {
    final uniqueMembers = <String>{creatorId, ...memberIds}.toList();

    LoggerService.debug('createChatRoom: teamId=$teamId, memberCount=${uniqueMembers.length}', tag: 'ChatRemoteDataSource');
    await supabaseClient.from('chat_rooms').upsert(
      {
        'team_id': teamId,
        'team_name': teamName,
      },
      onConflict: 'team_id',
    );

    final now = DateTime.now().toUtc().toIso8601String();
    final members = uniqueMembers.map((userId) => {
          'team_id': teamId,
          'user_id': userId,
          'unread_count': 0,
          'last_read_at': now,
        }).toList();

    await supabaseClient.from('room_members').upsert(
      members,
      onConflict: 'team_id, user_id',
    );
  }

  @override
  Future<List<MessageModel>> getMessages(String teamId, {String? lastCreatedAt, int limit = 20}) async {
    LoggerService.debug('getMessages: teamId=$teamId, lastCreatedAt=$lastCreatedAt', tag: 'ChatRemoteDataSource');

    var query = supabaseClient
        .from('messages')
        .select()
        .eq('team_id', teamId);

    if (lastCreatedAt != null) {
      query = query.lt('created_at', lastCreatedAt);
    }

    final response = await query
        .order('created_at', ascending: false)
        .limit(limit);

    return response.map<MessageModel>((json) => MessageModel.fromJson(json)).toList();
  }

  @override
  Future<MessageModel> sendMessage(String teamId, String content, String senderName) async {
    LoggerService.debug('sendMessage: teamId=$teamId', tag: 'ChatRemoteDataSource');
    final userId = await _getCurrentUserId('sendMessage');

    final response = await supabaseClient
        .from('messages')
        .insert({
          'team_id': teamId,
          'sender_id': userId,
          'sender_name': senderName,
          'content': content.trim(),
        })
        .select()
        .single();

    return MessageModel.fromJson(response);
  }

  @override
  Stream<MessageModel> watchMessages(String teamId) {
    try {
      _messagesChannel?.unsubscribe();
      _messagesChannel = supabaseClient.channel('public:messages:$teamId');

      _messagesChannel!.onPostgresChanges(
        event: PostgresChangeEvent.insert,
        schema: 'public',
        table: 'messages',
        filter: PostgresChangeFilter(
          column: 'team_id',
          value: teamId,
          type: PostgresChangeFilterType.eq,
        ),
        callback: (payload) {
          if (_disposed) return;
          LoggerService.debug('New message via realtime: teamId=$teamId', tag: 'ChatRemoteDataSource');
          final message = MessageModel.fromJson(payload.newRecord);
          if (!_disposed) _messagesStreamController.add(message);
        },
      ).subscribe();

      LoggerService.debug('Subscribed to messages realtime: teamId=$teamId', tag: 'ChatRemoteDataSource');

      return _messagesStreamController.stream;
    } catch (e) {
      LoggerService.error('watchMessages failed', exception: e, tag: 'ChatRemoteDataSource');
      return Stream.error(e);
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _realtimeDebounce?.cancel();
    _realtimeChannel?.unsubscribe();
    _chatRoomsStreamController.close();
    _messagesChannel?.unsubscribe();
    _messagesStreamController.close();
  }
}