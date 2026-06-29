import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/features/profile/data/datasource/profile_remote_data_source.dart';
import 'package:bridge_x/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:bridge_x/features/profile/domain/repositories/profile_repository.dart';
import 'package:bridge_x/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:bridge_x/features/profile/domain/usecases/get_profile_dashboard_usecase.dart';
import 'package:bridge_x/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:bridge_x/features/profile/domain/usecases/soft_delete_profile_usecase.dart';
import 'package:bridge_x/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:bridge_x/features/profile/presentation/controller/change_password_cubit.dart';
import 'package:bridge_x/features/profile/presentation/controller/edit_profile_cubit.dart';
import 'package:bridge_x/features/profile/presentation/controller/profile_dashboard_cubit.dart';

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
  sl.registerLazySingleton<GetProfileUseCase>(
    () => GetProfileUseCase(repository: sl()),
  );
  sl.registerLazySingleton<UpdateProfileUseCase>(
    () => UpdateProfileUseCase(repository: sl()),
  );
  sl.registerLazySingleton<ChangePasswordUseCase>(
    () => ChangePasswordUseCase(repository: sl()),
  );
  sl.registerLazySingleton<SoftDeleteProfileUseCase>(
    () => SoftDeleteProfileUseCase(repository: sl()),
  );

  // Cubits
  sl.registerFactory<ProfileDashboardCubit>(
    () => ProfileDashboardCubit(getProfileDashboardUseCase: sl()),
  );
  sl.registerFactory<EditProfileCubit>(
    () => EditProfileCubit(getProfileUseCase: sl(), updateProfileUseCase: sl(), secureStorageService: sl()),
  );
  sl.registerFactory<ChangePasswordCubit>(
    () => ChangePasswordCubit(changePasswordUseCase: sl()),
  );
}
