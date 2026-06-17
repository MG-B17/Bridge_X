import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/feature/chats/data/datasource/chats_remote_data_source.dart';
import 'package:bridge_x/feature/chats/data/repositories/chats_repository_impl.dart';
import 'package:bridge_x/feature/chats/domain/repositories/chats_repository.dart';
import 'package:bridge_x/feature/chats/domain/usecases/get_my_chats_usecase.dart';
import 'package:bridge_x/feature/chats/presentation/controller/chats_cubit.dart';

void initChats() {
  // Usecases
  sl.registerLazySingleton<GetMyChatsUseCase>(
    () => GetMyChatsUseCase(repository: sl()),
  );

  // Repositories
  sl.registerLazySingleton<ChatsRepository>(
    () => ChatsRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ChatsRemoteDataSource>(
    () => ChatsRemoteDataSourceImpl(apiClient: sl()),
  );

  // Cubit
  sl.registerFactory<ChatsCubit>(
    () => ChatsCubit(getMyChatsUseCase: sl()),
  );
}
