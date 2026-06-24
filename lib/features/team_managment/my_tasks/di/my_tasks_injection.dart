import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/features/team_managment/my_tasks/data/datasources/my_tasks_remote_data_source.dart';
import 'package:bridge_x/features/team_managment/my_tasks/data/repositories/my_tasks_repository_impl.dart';
import 'package:bridge_x/features/team_managment/my_tasks/domain/repositories/my_tasks_repository.dart';
import 'package:bridge_x/features/team_managment/my_tasks/domain/usecases/get_active_tasks_usecase.dart';
import 'package:bridge_x/features/team_managment/my_tasks/domain/usecases/get_completed_tasks_usecase.dart';
import 'package:bridge_x/features/team_managment/my_tasks/domain/usecases/get_task_details_usecase.dart';
import 'package:bridge_x/features/team_managment/my_tasks/presentation/cubit/my_tasks_cubit.dart';

void initMyTasks() {
  sl.registerLazySingleton<MyTasksRemoteDataSource>(
    () => MyTasksRemoteDataSourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<MyTasksRepository>(
    () => MyTasksRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<GetActiveTasksUseCase>(
    () => GetActiveTasksUseCase(repository: sl()),
  );
  sl.registerLazySingleton<GetCompletedTasksUseCase>(
    () => GetCompletedTasksUseCase(repository: sl()),
  );
  sl.registerLazySingleton<GetTaskDetailsUseCase>(
    () => GetTaskDetailsUseCase(repository: sl()),
  );
  sl.registerFactory<MyTasksCubit>(
    () => MyTasksCubit(
      getActiveTasksUseCase: sl(),
      getCompletedTasksUseCase: sl(),
      getTaskDetailsUseCase: sl(),
    ),
  );
}
