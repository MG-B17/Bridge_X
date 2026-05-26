import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/feature/profile/data/datasource/profile_remote_data_source.dart';
import 'package:bridge_x/feature/profile/data/repositories/profile_repository_impl.dart';
import 'package:bridge_x/feature/profile/domain/repositories/profile_repository.dart';
import 'package:bridge_x/feature/profile/domain/usecases/get_profile_dashboard_usecase.dart';
import 'package:bridge_x/feature/profile/presentation/controller/profile_dashboard_cubit.dart';

void initProfile() {
  // Data sources
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(apiClient: sl()),
  );

  // Repositories
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Usecases
  sl.registerLazySingleton<GetProfileDashboardUseCase>(
    () => GetProfileDashboardUseCase(repository: sl()),
  );

  // Cubit
  sl.registerFactory<ProfileDashboardCubit>(
    () => ProfileDashboardCubit(getProfileDashboardUseCase: sl()),
  );
}
