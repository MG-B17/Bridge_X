import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/feature/projects_management/data/datasources/local/projects_management_local_data.dart';
import 'package:bridge_x/feature/projects_management/data/datasources/remote/projects_management_remote_data_source.dart';
import 'package:bridge_x/feature/projects_management/data/repositories/projects_management_repository_impl.dart';
import 'package:bridge_x/feature/projects_management/domain/repositories/projects_management_repository.dart';
import 'package:bridge_x/feature/projects_management/domain/usecases/create_task_usecase.dart';
import 'package:bridge_x/feature/projects_management/domain/usecases/get_all_projects_usecase.dart';
import 'package:bridge_x/feature/projects_management/domain/usecases/get_completed_project_details_usecase.dart';
import 'package:bridge_x/feature/projects_management/domain/usecases/get_project_dashboard_usecase.dart';
import 'package:bridge_x/feature/projects_management/domain/usecases/get_project_details_usecase.dart';
import 'package:bridge_x/feature/projects_management/domain/usecases/get_team_settings_usecase.dart';
import 'package:bridge_x/feature/projects_management/domain/usecases/submit_project_as_complete_usecase.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/completed_project_details/completed_project_details_cubit.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/create_task/create_task_cubit.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/project_dashboard/project_dashboard_bloc.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/project_details/project_details_bloc.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/projects_list/projects_list_bloc.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/submit_project/submit_project_cubit.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/team_settings/team_settings_bloc.dart';

void initProjectsManagement() {
  // Data sources
  sl.registerLazySingleton<ProjectsManagementLocalData>(
    () => ProjectsManagementLocalDataImpl(cacheService: sl()),
  );

  sl.registerLazySingleton<ProjectsManagementRemoteDataSource>(
    () => ProjectsManagementRemoteDataSourceImpl(apiClient: sl()),
  );

  // Repository
  sl.registerLazySingleton<ProjectsManagementRepository>(
    () => ProjectsManagementRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton<GetAllProjectsUseCase>(
    () => GetAllProjectsUseCase(repository: sl()),
  );

  sl.registerLazySingleton<GetProjectDashboardUseCase>(
    () => GetProjectDashboardUseCase(repository: sl()),
  );

  sl.registerLazySingleton<GetTeamSettingsUseCase>(
    () => GetTeamSettingsUseCase(repository: sl()),
  );

  sl.registerLazySingleton<SubmitProjectAsCompleteUseCase>(
    () => SubmitProjectAsCompleteUseCase(repository: sl()),
  );

  sl.registerLazySingleton<GetProjectDetailsUseCase>(
    () => GetProjectDetailsUseCase(repository: sl()),
  );

  sl.registerLazySingleton<GetCompletedProjectDetailsUseCase>(
    () => GetCompletedProjectDetailsUseCase(repository: sl()),
  );

  sl.registerLazySingleton<CreateTaskUseCase>(
    () => CreateTaskUseCase(repository: sl()),
  );

  // Blocs
  sl.registerFactory<ProjectsListBloc>(
    () => ProjectsListBloc(getAllProjectsUseCase: sl()),
  );

  sl.registerFactory<ProjectDashboardBloc>(
    () => ProjectDashboardBloc(getProjectDashboardUseCase: sl()),
  );

  sl.registerFactory<ProjectDetailsBloc>(
    () => ProjectDetailsBloc(getProjectDetailsUseCase: sl()),
  );

  sl.registerFactory<CompletedProjectDetailsCubit>(
    () => CompletedProjectDetailsCubit(useCase: sl()),
  );

  sl.registerFactory<CreateTaskCubit>(
    () => CreateTaskCubit(createTaskUseCase: sl(), repository: sl()),
  );

  sl.registerFactory<TeamSettingsBloc>(
    () => TeamSettingsBloc(getTeamSettingsUseCase: sl()),
  );

  sl.registerFactory<SubmitProjectCubit>(
    () => SubmitProjectCubit(submitProjectAsCompleteUseCase: sl()),
  );
}
