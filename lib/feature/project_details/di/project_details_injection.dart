import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/feature/project_details/data/datasource/remote/project_details_remote_data.dart';
import 'package:bridge_x/feature/project_details/data/repositories/project_details_repository_impl.dart';
import 'package:bridge_x/feature/project_details/domain/repositories/project_details_repository.dart';
import 'package:bridge_x/feature/project_details/domain/usecases/get_project_details_usecase.dart';
import 'package:bridge_x/feature/project_details/presentation/cubit/project_details_cubit.dart';

void initProjectDetails() {
  sl.registerLazySingleton<ProjectDetailsRemoteData>(
    () => ProjectDetailsRemoteDataImpl(apiClient: sl()),
  );

  sl.registerLazySingleton<ProjectDetailsRepository>(
    () => ProjectDetailsRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<GetProjectDetailsUseCase>(
    () => GetProjectDetailsUseCase(repository: sl()),
  );

  sl.registerFactory<ProjectDetailsCubit>(
    () => ProjectDetailsCubit(getProjectDetailsUseCase: sl()),
  );
}
