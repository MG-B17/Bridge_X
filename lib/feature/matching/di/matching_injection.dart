import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/feature/matching/data/datasources/matching_remote_data_source.dart';
import 'package:bridge_x/feature/matching/data/repositories/matching_repository_impl.dart';
import 'package:bridge_x/feature/matching/domain/repositories/matching_repository.dart';
import 'package:bridge_x/feature/matching/domain/usecases/get_ai_matches_usecase.dart';
import 'package:bridge_x/feature/matching/presentation/cubit/matching_cubit.dart';

void initMatching() {
  sl.registerLazySingleton<MatchingRemoteDataSource>(
    () => MatchingRemoteDataSourceImpl(apiClient: sl()),
  );

  sl.registerLazySingleton<MatchingRepository>(
    () => MatchingRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<GetAiMatchesUseCase>(
    () => GetAiMatchesUseCase(repository: sl()),
  );

  sl.registerLazySingleton<MatchingCubit>(
    () => MatchingCubit(getAiMatchesUseCase: sl()),
  );
}
