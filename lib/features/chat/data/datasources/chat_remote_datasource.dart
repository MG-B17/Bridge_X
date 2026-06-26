import 'dart:async';
import 'package:bridge_x/core/services/logger_service.dart';
import 'package:bridge_x/features/chat/data/models/chat_room_model.dart';
import 'package:bridge_x/features/chat/data/models/chat_user_model.dart';
import 'package:bridge_x/features/chat/data/models/invitation_model.dart';
import 'package:bridge_x/features/chat/data/models/join_request_model.dart';
import 'package:bridge_x/features/chat/data/models/message_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ChatRemoteDataSource {
  // Chat Rooms
  Future<List<ChatRoomModel>> getChatRooms(int userId);
  Future<List<ChatRoomModel>> searchChatRooms(int userId, String query);
  Stream<List<ChatRoomModel>> subscribeToChatRooms(int userId);
  Future<void> createChatRoom(int teamId, String teamName, int creatorId, List<int> memberIds);
  Future<void> changeChatRoomLeader(String roomId, int newLeaderId, int oldLeaderId);
  Future<void> deleteChatRoom(String roomId);

  // Messages
  Future<List<MessageModel>> getMessages(String roomId, int userId, {String? cursor, int limit = 20});
  Future<MessageModel> sendMessage(String roomId, int senderId, String content);
  Future<void> editMessage(String messageId, String newContent);
  Future<void> deleteMessage(String messageId);
  Stream<MessageModel> watchMessages(String roomId, int userId);

  // Message Status
  Future<void> markMessagesDelivered(String roomId, int userId);
  Future<void> markMessageRead(String messageId, int userId);
  Future<void> resetUnreadCount(String roomId, int userId);

  // Join Requests
  Future<void> sendJoinRequest(String roomId, int userId);
  Future<List<JoinRequestModel>> getJoinRequests(String roomId);
  Future<void> acceptJoinRequest(String requestId);
  Future<void> rejectJoinRequest(String requestId);

  // Invitations
  Future<void> sendInvitation(String roomId, int inviterId, int inviteeId);
  Future<List<InvitationModel>> getInvitations(int userId);
  Future<void> acceptInvitation(String invitationId);
  Future<void> rejectInvitation(String invitationId);

  // Chat Users
  Future<void> saveUserChatData(int userId, String username, String? email);
  Future<ChatUserModel?> getUserChatData(int userId);
  Future<void> deleteUserChatData(int userId);
  Future<void> updateUsername(int userId, String newUsername);

  // Members
  Future<List<ChatUserModel>> getRoomMembers(String roomId);

  void dispose();
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final SupabaseClient supabaseClient;
  bool _disposed = false;

  // Chat list realtime
  StreamController<List<ChatRoomModel>>? _chatRoomsStreamController;
  RealtimeChannel? _chatRoomsChannel;
  Timer? _realtimeDebounce;

  // Messages realtime (per room)
  final Map<String, _MessageRealtimeState> _messageChannels = {};

  ChatRemoteDataSourceImpl({required this.supabaseClient});

  @override
  void dispose() {
    _disposed = true;
    _realtimeDebounce?.cancel();
    _chatRoomsChannel?.unsubscribe();
    _chatRoomsStreamController?.close();
    for (final entry in _messageChannels.values) {
      entry.channel.unsubscribe();
      entry.controller.close();
    }
    _messageChannels.clear();
  }

  // ===================== Chat Rooms =====================

  @override
  Future<List<ChatRoomModel>> getChatRooms(int userId) async {
    LoggerService.debug('getChatRooms: userId=$userId', tag: 'ChatRemoteDataSource');

    final response = await supabaseClient
        .from('chat_room_members')
        .select('''
          room_id, user_id, role, unread_count,
          chat_rooms!inner(team_id, team_name, leader_id, is_active),
          chat_room_previews!left(last_message, last_message_at, last_message_sender_id)
        ''')
        .eq('user_id', userId)
        .eq('chat_rooms.is_active', true)
        .order('last_message_at', referencedTable: 'chat_room_previews', ascending: false, nullsFirst: false);

    return await _enrichChatRoomsWithSenderNames(response);
  }

  @override
  Future<List<ChatRoomModel>> searchChatRooms(int userId, String query) async {
    LoggerService.debug('searchChatRooms: query="$query"', tag: 'ChatRemoteDataSource');

    final response = await supabaseClient
        .from('chat_room_members')
        .select('''
          room_id, user_id, role, unread_count,
          chat_rooms!inner(team_id, team_name, leader_id, is_active),
          chat_room_previews!left(last_message, last_message_at, last_message_sender_id)
        ''')
        .eq('user_id', userId)
        .eq('chat_rooms.is_active', true)
        .ilike('chat_rooms.team_name', '%$query%')
        .order('last_message_at', referencedTable: 'chat_room_previews', ascending: false, nullsFirst: false);

    return await _enrichChatRoomsWithSenderNames(response);
  }

  Future<List<ChatRoomModel>> _enrichChatRoomsWithSenderNames(List<dynamic> rows) async {
    final rooms = rows.map((json) => ChatRoomModel.fromJson(json)).toList();

    final senderIds = rooms
        .map((r) => r.lastMessageSenderId)
        .whereType<int>()
        .toSet()
        .toList();

    if (senderIds.isEmpty) return rooms;

    final userResponse = await supabaseClient
        .from('chat_users')
        .select('user_id, username')
        .inFilter('user_id', senderIds);

    final usernameMap = {for (final u in userResponse) u['user_id'] as int: u['username'] as String};

    return rooms.map((room) {
      if (room.lastMessageSenderId != null && usernameMap.containsKey(room.lastMessageSenderId)) {
        return room.copyWith(
          lastMessageSenderName: usernameMap[room.lastMessageSenderId],
        ) as ChatRoomModel;
      }
      return room;
    }).toList();
  }

  @override
  Stream<List<ChatRoomModel>> subscribeToChatRooms(int userId) {
    _chatRoomsStreamController?.close();
    _chatRoomsStreamController = StreamController<List<ChatRoomModel>>.broadcast();

    _chatRoomsChannel?.unsubscribe();
    _chatRoomsChannel = supabaseClient.channel('chat_list:$userId');

    void refreshChatRooms() {
      _realtimeDebounce?.cancel();
      _realtimeDebounce = Timer(const Duration(milliseconds: 300), () async {
        if (_disposed) return;
        try {
          final rooms = await getChatRooms(userId);
          if (!_disposed) _chatRoomsStreamController!.add(rooms);
        } catch (e) {
          LoggerService.error('Failed to refresh chat rooms', exception: e, tag: 'ChatRemoteDataSource');
          if (!_disposed) _chatRoomsStreamController!.addError(e);
        }
      });
    }

    _chatRoomsChannel!
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'chat_room_members',
          filter: PostgresChangeFilter(
            column: 'user_id',
            value: userId.toString(),
            type: PostgresChangeFilterType.eq,
          ),
          callback: (_) => refreshChatRooms(),
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'chat_room_previews',
          callback: (_) => refreshChatRooms(),
        )
        .subscribe();

    LoggerService.debug('Subscribed to chat_list:$userId', tag: 'ChatRemoteDataSource');

    return _chatRoomsStreamController!.stream;
  }

  @override
  Future<void> createChatRoom(int teamId, String teamName, int creatorId, List<int> memberIds) async {
    LoggerService.debug('createChatRoom: teamId=$teamId', tag: 'ChatRemoteDataSource');

    final roomResponse = await supabaseClient
        .from('chat_rooms')
        .insert({'team_id': teamId, 'team_name': teamName})
        .select('room_id')
        .single();

    final roomId = roomResponse['room_id'] as String;

    final now = DateTime.now().toUtc().toIso8601String();
    final allUserIds = <int>{creatorId, ...memberIds}.toList();

    final members = allUserIds.map((uid) => {
      'room_id': roomId,
      'user_id': uid,
      'role': uid == creatorId ? 'leader' : 'member',
      'unread_count': 0,
      'last_read_at': now,
      'joined_at': now,
    }).toList();

    await supabaseClient.from('chat_room_members').upsert(members, onConflict: 'room_id, user_id');
  }

  @override
  Future<void> changeChatRoomLeader(String roomId, int newLeaderId, int oldLeaderId) async {
    LoggerService.debug('changeChatRoomLeader: roomId=$roomId, newLeader=$newLeaderId', tag: 'ChatRemoteDataSource');

    await supabaseClient.rpc('change_chat_room_leader', params: {
      'p_room_id': roomId,
      'p_new_leader_id': newLeaderId,
      'p_old_leader_id': oldLeaderId,
    });
  }

  @override
  Future<void> deleteChatRoom(String roomId) async {
    LoggerService.debug('deleteChatRoom: roomId=$roomId', tag: 'ChatRemoteDataSource');
    await supabaseClient.from('chat_rooms').delete().eq('room_id', roomId);
  }

  // ===================== Messages =====================

  @override
  Future<List<MessageModel>> getMessages(String roomId, int userId, {String? cursor, int limit = 20}) async {
    LoggerService.debug('getMessages: roomId=$roomId, cursor=$cursor', tag: 'ChatRemoteDataSource');

    var query = supabaseClient
        .from('messages')
        .select('''
          message_id, room_id, sender_id, content, is_edited, is_deleted, created_at,
          chat_users!sender_id(username)
        ''')
        .eq('room_id', roomId);

    if (cursor != null) {
      query = query.lt('created_at', cursor);
    }

    final response = await query.order('created_at', ascending: false).limit(limit);

    return await _enrichMessagesWithStatus(response, userId);
  }

  Future<List<MessageModel>> _enrichMessagesWithStatus(List<dynamic> rows, int userId) async {
    if (rows.isEmpty) return [];

    final messageIds = rows.map((m) => m['message_id'] as String).toList();

    final statusResponse = await supabaseClient
        .from('message_status')
        .select('message_id, status')
        .eq('user_id', userId)
        .inFilter('message_id', messageIds);

    final statusMap = {
      for (final s in statusResponse)
        s['message_id'] as String: s['status'] as String
    };

    return rows.map((json) {
      final jsonMap = json as Map<String, dynamic>;
      final status = statusMap[jsonMap['message_id']];
      if (status != null) {
        jsonMap['my_status'] = status;
      }
      return MessageModel.fromJson(jsonMap);
    }).toList();
  }

  @override
  Future<MessageModel> sendMessage(String roomId, int senderId, String content) async {
    LoggerService.debug('sendMessage: roomId=$roomId', tag: 'ChatRemoteDataSource');

    final response = await supabaseClient
        .from('messages')
        .insert({
          'room_id': roomId,
          'sender_id': senderId,
          'content': content.trim(),
        })
        .select('''
          message_id, room_id, sender_id, content, is_edited, is_deleted, created_at,
          chat_users!sender_id(username)
        ''')
        .single();

    return MessageModel.fromJson(response);
  }

  @override
  Future<void> editMessage(String messageId, String newContent) async {
    LoggerService.debug('editMessage: messageId=$messageId', tag: 'ChatRemoteDataSource');
    await supabaseClient
        .from('messages')
        .update({'content': newContent.trim(), 'is_edited': true, 'edited_at': DateTime.now().toUtc().toIso8601String()})
        .eq('message_id', messageId);
  }

  @override
  Future<void> deleteMessage(String messageId) async {
    LoggerService.debug('deleteMessage: messageId=$messageId', tag: 'ChatRemoteDataSource');
    await supabaseClient
        .from('messages')
        .update({'is_deleted': true})
        .eq('message_id', messageId);
  }

  @override
  Stream<MessageModel> watchMessages(String roomId, int userId) {
    _messageChannels[roomId]?.channel.unsubscribe();
    _messageChannels[roomId]?.controller.close();

    final controller = StreamController<MessageModel>.broadcast();
    final channel = supabaseClient.channel('messages:$roomId');

    channel.onPostgresChanges(
      event: PostgresChangeEvent.insert,
      schema: 'public',
      table: 'messages',
      filter: PostgresChangeFilter(
        column: 'room_id',
        value: roomId,
        type: PostgresChangeFilterType.eq,
      ),
      callback: (payload) async {
        if (_disposed) return;
        try {
          final json = payload.newRecord;
          final senderResponse = await supabaseClient
              .from('chat_users')
              .select('username')
              .eq('user_id', json['sender_id'] as int)
              .maybeSingle();

          json['sender_name'] = senderResponse?['username'] as String? ?? '';

          final statusResponse = await supabaseClient
              .from('message_status')
              .select('status')
              .eq('message_id', json['message_id'] as String)
              .eq('user_id', userId)
              .maybeSingle();

          if (statusResponse != null) {
            json['my_status'] = statusResponse['status'] as String;
          }

          if (!_disposed) {
            controller.add(MessageModel.fromJson(json));
          }
        } catch (e) {
          LoggerService.error('watchMessages insert error', exception: e, tag: 'ChatRemoteDataSource');
        }
      },
    ).onPostgresChanges(
      event: PostgresChangeEvent.update,
      schema: 'public',
      table: 'messages',
      filter: PostgresChangeFilter(
        column: 'room_id',
        value: roomId,
        type: PostgresChangeFilterType.eq,
      ),
      callback: (payload) async {
        if (_disposed) return;
        try {
          final json = payload.newRecord;
          final senderResponse = await supabaseClient
              .from('chat_users')
              .select('username')
              .eq('user_id', json['sender_id'] as int)
              .maybeSingle();

          json['sender_name'] = senderResponse?['username'] as String? ?? '';

          if (!_disposed) {
            controller.add(MessageModel.fromJson(json));
          }
        } catch (e) {
          LoggerService.error('watchMessages update error', exception: e, tag: 'ChatRemoteDataSource');
        }
      },
    ).subscribe();

    _messageChannels[roomId] = _MessageRealtimeState(controller: controller, channel: channel);

    return controller.stream;
  }

  // ===================== Message Status =====================

  @override
  Future<void> markMessagesDelivered(String roomId, int userId) async {
    await supabaseClient.rpc('mark_messages_delivered', params: {
      'p_room_id': roomId,
      'p_user_id': userId,
    });
  }

  @override
  Future<void> markMessageRead(String messageId, int userId) async {
    await supabaseClient
        .from('message_status')
        .update({'status': 'read', 'updated_at': DateTime.now().toUtc().toIso8601String()})
        .eq('message_id', messageId)
        .eq('user_id', userId);
  }

  @override
  Future<void> resetUnreadCount(String roomId, int userId) async {
    await supabaseClient
        .from('chat_room_members')
        .update({'unread_count': 0, 'last_read_at': DateTime.now().toUtc().toIso8601String()})
        .eq('room_id', roomId)
        .eq('user_id', userId);
  }

  // ===================== Join Requests =====================

  @override
  Future<void> sendJoinRequest(String roomId, int userId) async {
    await supabaseClient
        .from('join_requests')
        .insert({'room_id': roomId, 'user_id': userId});
  }

  @override
  Future<List<JoinRequestModel>> getJoinRequests(String roomId) async {
    final response = await supabaseClient
        .from('join_requests')
        .select('''
          request_id, room_id, user_id, status, created_at,
          chat_users!user_id(username)
        ''')
        .eq('room_id', roomId);

    return response.map((json) => JoinRequestModel.fromJson(json)).toList();
  }

  @override
  Future<void> acceptJoinRequest(String requestId) async {
    await supabaseClient.rpc('accept_join_request', params: {
      'p_request_id': requestId,
    });
  }

  @override
  Future<void> rejectJoinRequest(String requestId) async {
    await supabaseClient
        .from('join_requests')
        .update({'status': 'rejected', 'updated_at': DateTime.now().toUtc().toIso8601String()})
        .eq('request_id', requestId);
  }

  // ===================== Invitations =====================

  @override
  Future<void> sendInvitation(String roomId, int inviterId, int inviteeId) async {
    await supabaseClient
        .from('invitations')
        .insert({'room_id': roomId, 'inviter_id': inviterId, 'invitee_id': inviteeId});
  }

  @override
  Future<List<InvitationModel>> getInvitations(int userId) async {
    final response = await supabaseClient
        .from('invitations')
        .select('''
          invitation_id, room_id, inviter_id, invitee_id, status, created_at,
          chat_rooms!room_id(team_name),
          chat_users!inviter_id(username)
        ''')
        .eq('invitee_id', userId)
        .order('created_at', ascending: false);

    return response.map((json) {
      final chatRoom = json['chat_rooms'] as Map<String, dynamic>;
      final inviter = json['chat_users'] as Map<String, dynamic>;
      json['team_name'] = chatRoom['team_name'];
      json['inviter_name'] = inviter['username'];
      return InvitationModel.fromJson(json);
    }).toList();
  }

  @override
  Future<void> acceptInvitation(String invitationId) async {
    await supabaseClient.rpc('accept_invitation', params: {
      'p_invitation_id': invitationId,
    });
  }

  @override
  Future<void> rejectInvitation(String invitationId) async {
    await supabaseClient
        .from('invitations')
        .update({'status': 'rejected', 'updated_at': DateTime.now().toUtc().toIso8601String()})
        .eq('invitation_id', invitationId);
  }

  // ===================== Chat Users =====================

  @override
  Future<void> saveUserChatData(int userId, String username, String? email) async {
    await supabaseClient.from('chat_users').upsert({
      'user_id': userId,
      'username': username,
      if (email != null) 'email': email,
    }, onConflict: 'user_id');
  }

  @override
  Future<ChatUserModel?> getUserChatData(int userId) async {
    final response = await supabaseClient
        .from('chat_users')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    if (response == null) return null;
    return ChatUserModel.fromJson(response);
  }

  @override
  Future<void> deleteUserChatData(int userId) async {
    await supabaseClient.from('chat_users').delete().eq('user_id', userId);
  }

  @override
  Future<void> updateUsername(int userId, String newUsername) async {
    await supabaseClient
        .from('chat_users')
        .update({'username': newUsername})
        .eq('user_id', userId);
  }

  // ===================== Members =====================

  @override
  Future<List<ChatUserModel>> getRoomMembers(String roomId) async {
    final response = await supabaseClient
        .from('chat_room_members')
        .select('''
          user_id,
          chat_users!user_id(username, email, avatar_url)
        ''')
        .eq('room_id', roomId);

    return response.map((json) {
      final user = json['chat_users'] as Map<String, dynamic>;
      return ChatUserModel.fromJson({
        'user_id': json['user_id'] as int,
        'username': user['username'] as String,
        'email': user['email'] as String?,
        'avatar_url': user['avatar_url'] as String?,
      });
    }).toList();
  }
}

class _MessageRealtimeState {
  final StreamController<MessageModel> controller;
  final RealtimeChannel channel;

  _MessageRealtimeState({required this.controller, required this.channel});
}
