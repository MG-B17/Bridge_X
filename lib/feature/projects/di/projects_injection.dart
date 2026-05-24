import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/feature/projects/data/data_source/local/all_projects_local_data.dart';
import 'package:bridge_x/feature/projects/data/data_source/remote/all_projects_remote_data.dart';
import 'package:bridge_x/feature/projects/data/repo_implement/all_projects_repo_implement.dart';
import 'package:bridge_x/feature/projects/domain/repo/all_projects_repo.dart';
import 'package:bridge_x/feature/projects/domain/usecases/get_all_projects_usecase.dart';
import 'package:bridge_x/feature/projects/presentation/controller/all_projects_cubit.dart';

void initProjects() {
  // Local Data Source
  sl.registerLazySingleton<AllProjectsLocalData>(
    () => AllProjectsLocalDataImpl(cacheService: sl()),
  );

  // Remote Data Source
  sl.registerLazySingleton<AllProjectsRemoteData>(
    () => AllProjectsRemoteDataImpl(apiClient: sl()),
  );

  // Repository
  sl.registerLazySingleton<AllProjectsRepo>(
    () => AllProjectsRepoImplement(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // UseCase
  sl.registerLazySingleton<GetAllProjectsUseCase>(
    () => GetAllProjectsUseCase(repository: sl()),
  );

  // Cubit
  sl.registerFactory<AllProjectsCubit>(
    () => AllProjectsCubit(getAllProjectsUseCase: sl()),
  );
}
