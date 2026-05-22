import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/feature/dashboard/data/datasource/local/dashboard_local_data_source.dart';
import 'package:bridge_x/feature/dashboard/data/datasource/remote/dashboard_remote_data_source.dart';
import 'package:bridge_x/feature/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:bridge_x/feature/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:bridge_x/feature/dashboard/domain/usecases/get_local_dashboard_usecase.dart';
import 'package:bridge_x/feature/dashboard/domain/usecases/get_remote_dashboard_usecase.dart';
import 'package:bridge_x/feature/dashboard/presentation/cubit/dashboard_cubit.dart';

void initDashboard() {
  // Usecases
  sl.registerLazySingleton<GetRemoteDashboardUseCase>(
    () => GetRemoteDashboardUseCase(repository: sl()),
  );
  sl.registerLazySingleton<GetLocalDashboardUseCase>(
    () => GetLocalDashboardUseCase(repository: sl()),
  );

  // Repositories
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()),
  );

  // Data sources
  sl.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<DashboardLocalDataSource>(
    () => DashboardLocalDataSourceImpl(cacheService: sl(), appLifecycleService: sl()),
  );

  // Cubit
  sl.registerFactory<DashboardCubit>(
    () => DashboardCubit(getRemoteDashboardUseCase: sl(), getLocalDashboardUseCase: sl()),
  );
}
