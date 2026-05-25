import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/feature/create_task/data/datasources/create_task_remote_data_source.dart';
import 'package:bridge_x/feature/create_task/data/repositories/create_task_repository_impl.dart';
import 'package:bridge_x/feature/create_task/domain/repositories/create_task_repository.dart';
import 'package:bridge_x/feature/create_task/domain/usecases/create_task_usecase.dart';
import 'package:bridge_x/feature/create_task/presentation/cubit/create_task_cubit.dart';

void initCreateTask() {
  sl.registerLazySingleton<CreateTaskRemoteDataSource>(
    () => CreateTaskRemoteDataSourceImpl(apiClient: sl()),
  );

  sl.registerLazySingleton<CreateTaskRepository>(
    () => CreateTaskRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  sl.registerLazySingleton<CreateTaskUseCase>(
    () => CreateTaskUseCase(repository: sl()),
  );

  sl.registerFactory<CreateTaskCubit>(
    () => CreateTaskCubit(createTaskUseCase: sl(), repository: sl()),
  );
}
