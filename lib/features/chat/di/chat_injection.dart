import 'package:bridge_x/features/chat/data/datasources/chat_remote_datasource.dart';
import 'package:bridge_x/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:bridge_x/features/chat/domain/usecases/accept_invitation_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/accept_join_request_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/change_leader_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/create_team_chat_room_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/delete_chat_room_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/delete_message_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/delete_user_chat_data_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/edit_message_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/get_chat_rooms_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/get_invitations_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/get_join_requests_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/get_messages_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/get_room_members_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/get_user_chat_data_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/mark_message_read_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/mark_messages_delivered_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/reject_invitation_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/reject_join_request_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/reset_unread_count_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/save_user_chat_data_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/search_chat_rooms_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/send_invitation_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/send_join_request_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/subscribe_to_chat_rooms_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/update_username_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/watch_connection_status_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/watch_messages_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/watch_room_membership_usecase.dart';
import 'package:bridge_x/features/chat/presentation/bloc/chat_list_cubit.dart';
import 'package:bridge_x/features/chat/presentation/bloc/chat_room_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:bridge_x/core/services/supabase_service.dart';

final sl = GetIt.instance;

void initChatList() {
  // Data source
  sl.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(supabaseClient: sl<SupabaseService>().client),
    dispose: (ds) => ds.dispose(),
  );

  // Repository
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetChatRooms(sl()));
  sl.registerLazySingleton(() => SearchChatRooms(sl()));
  sl.registerLazySingleton(() => SubscribeToChatRooms(sl()));
  sl.registerLazySingleton(() => CreateTeamChatRoom(sl()));
  sl.registerLazySingleton(() => ResetUnreadCount(sl()));
  sl.registerLazySingleton(() => GetMessages(sl()));
  sl.registerLazySingleton(() => SendMessage(sl()));
  sl.registerLazySingleton(() => WatchMessages(sl()));
  sl.registerLazySingleton(() => WatchRoomMembership(sl()));
  sl.registerLazySingleton(() => WatchConnectionStatus(sl()));
  sl.registerLazySingleton(() => ChangeLeader(sl()));
  sl.registerLazySingleton(() => DeleteChatRoom(sl()));
  sl.registerLazySingleton(() => SendJoinRequest(sl()));
  sl.registerLazySingleton(() => SendInvitation(sl()));
  sl.registerLazySingleton(() => AcceptJoinRequest(sl()));
  sl.registerLazySingleton(() => AcceptInvitation(sl()));
  sl.registerLazySingleton(() => RejectJoinRequest(sl()));
  sl.registerLazySingleton(() => RejectInvitation(sl()));
  sl.registerLazySingleton(() => SaveUserChatData(sl()));
  sl.registerLazySingleton(() => GetUserChatData(sl()));
  sl.registerLazySingleton(() => DeleteUserChatData(sl()));
  sl.registerLazySingleton(() => UpdateUsername(sl()));
  sl.registerLazySingleton(() => DeleteMessage(sl()));
  sl.registerLazySingleton(() => EditMessage(sl()));
  sl.registerLazySingleton(() => MarkMessageRead(sl()));
  sl.registerLazySingleton(() => MarkMessagesDelivered(sl()));
  sl.registerLazySingleton(() => GetRoomMembers(sl()));
  sl.registerLazySingleton(() => GetJoinRequests(sl()));
  sl.registerLazySingleton(() => GetInvitations(sl()));

  // Cubits
  sl.registerFactoryParam<ChatRoomCubit, String, int>(
    (roomId, userId) => ChatRoomCubit(
      roomId: roomId,
      userId: userId,
      getMessagesUseCase: sl(),
      resetUnreadCountUseCase: sl(),
      sendMessageUseCase: sl(),
      watchMessagesUseCase: sl(),
      editMessageUseCase: sl(),
      deleteMessageUseCase: sl(),
      markMessageReadUseCase: sl(),
      markMessagesDeliveredUseCase: sl(),
      watchRoomMembershipUseCase: sl(),
    ),
  );
  sl.registerFactory(() => ChatListCubit(
        getChatRoomsUseCase: sl(),
        searchChatRoomsUseCase: sl(),
        subscribeToChatRoomsUseCase: sl(),
        resetUnreadCountUseCase: sl(),
        deleteChatRoomUseCase: sl(),
        changeLeaderUseCase: sl(),
        watchConnectionStatusUseCase: sl(),
      ));
}
