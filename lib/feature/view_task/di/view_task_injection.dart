import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/feature/view_task/data/datasources/view_task_remote_data_source.dart';
import 'package:bridge_x/feature/view_task/data/repositories/view_task_repository_impl.dart';
import 'package:bridge_x/feature/view_task/domain/repositories/view_task_repository.dart';
import 'package:bridge_x/feature/view_task/domain/usecases/get_view_task_usecase.dart';
import 'package:bridge_x/feature/view_task/presentation/cubit/view_task_cubit.dart';

void initViewTask() {
  sl.registerLazySingleton<ViewTaskRemoteDataSource>(
    () => ViewTaskRemoteDataSourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<ViewTaskRepository>(
    () => ViewTaskRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton<GetViewTaskUseCase>(
    () => GetViewTaskUseCase(repository: sl()),
  );
  sl.registerFactory<ViewTaskCubit>(
    () => ViewTaskCubit(useCase: sl()),
  );
}
