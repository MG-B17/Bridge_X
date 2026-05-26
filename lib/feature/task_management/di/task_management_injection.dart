import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/feature/task_management/data/datasources/task_remote_data_source.dart';
import 'package:bridge_x/feature/task_management/data/repositories/task_repository_impl.dart';
import 'package:bridge_x/feature/task_management/domain/repositories/task_repository.dart';
import 'package:bridge_x/feature/task_management/domain/usecases/create_task_usecase.dart';
import 'package:bridge_x/feature/task_management/domain/usecases/get_view_task_usecase.dart';
import 'package:bridge_x/feature/task_management/presentation/bloc/create_task/create_task_cubit.dart';
import 'package:bridge_x/feature/task_management/presentation/bloc/view_task/view_task_cubit.dart';

void initTaskManagement() {
  sl.registerLazySingleton<TaskRemoteDataSource>(
    () => TaskRemoteDataSourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton<CreateTaskUseCase>(
    () => CreateTaskUseCase(repository: sl()),
  );
  sl.registerLazySingleton<GetViewTaskUseCase>(
    () => GetViewTaskUseCase(repository: sl()),
  );
  sl.registerFactory<CreateTaskCubit>(
    () => CreateTaskCubit(createTaskUseCase: sl(), projectsRepository: sl()),
  );
  sl.registerFactory<ViewTaskCubit>(
    () => ViewTaskCubit(useCase: sl()),
  );
}
