import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/feature/levels/data/datasource/level_remote_data_source.dart';
import 'package:bridge_x/feature/levels/data/repositories/level_repository_impl.dart';
import 'package:bridge_x/feature/levels/domain/repositories/level_repository.dart';
import 'package:bridge_x/feature/levels/domain/usecases/get_level_usecase.dart';
import 'package:bridge_x/feature/levels/presentation/controller/level_cubit.dart';

void initLevels() {
  // Data sources
  sl.registerLazySingleton<LevelRemoteDataSource>(
    () => LevelRemoteDataSourceImpl(apiClient: sl()),
  );

  // Repositories
  sl.registerLazySingleton<LevelRepository>(
    () => LevelRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Usecases
  sl.registerLazySingleton<GetLevelUseCase>(
    () => GetLevelUseCase(repository: sl()),
  );

  // Cubit
  sl.registerFactory<LevelCubit>(
    () => LevelCubit(getLevelUseCase: sl()),
  );
}
