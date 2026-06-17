import 'package:bridge_x/features/chat/data/datasources/chat_remote_datasource.dart';
import 'package:bridge_x/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:bridge_x/features/chat/domain/usecases/get_chat_rooms_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/get_messages_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/reconcile_membership_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/reset_unread_count_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/search_chat_rooms_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/subscribe_to_chat_rooms_usecase.dart';
import 'package:bridge_x/features/chat/domain/usecases/watch_messages_usecase.dart';
import 'package:bridge_x/features/chat/presentation/bloc/chat_list_cubit.dart';
import 'package:bridge_x/features/chat/presentation/bloc/chat_room_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:bridge_x/core/services/supabase_service.dart';

final sl = GetIt.instance;

void initChatList() {
  // Data sources (innermost dependency first)
  sl.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(supabaseClient: sl<SupabaseService>().client, secureStorageService: sl()),
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
  sl.registerLazySingleton(() => ResetUnreadCount(sl()));
  sl.registerLazySingleton(() => ReconcileMembership(sl()));
  sl.registerLazySingleton(() => GetMessages(sl()));
  sl.registerLazySingleton(() => SendMessage(sl()));
  sl.registerLazySingleton(() => WatchMessages(sl()));

  // Cubits (outermost dependency)
  sl.registerFactoryParam<ChatRoomCubit, String, void>(
    (teamId, _) => ChatRoomCubit(
      teamId: teamId,
      getMessagesUseCase: sl(),
      resetUnreadCountUseCase: sl(),
      sendMessageUseCase: sl(),
      watchMessagesUseCase: sl(),
      secureStorageService: sl(),
    ),
  );
  sl.registerFactory(() => ChatListCubit(
        getChatRoomsUseCase: sl(),
        searchChatRoomsUseCase: sl(),
        subscribeToChatRoomsUseCase: sl(),
        resetUnreadCountUseCase: sl(),
        reconcileMembershipUseCase: sl(),
        secureStorageService: sl(),
      ));
}

