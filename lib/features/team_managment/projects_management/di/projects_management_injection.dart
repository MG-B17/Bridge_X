import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/features/team_managment/projects_management/data/datasources/remote/project_managment_base_class.dart';
import 'package:bridge_x/features/team_managment/projects_management/data/datasources/remote/projects_management_remote_data_source.dart';
import 'package:bridge_x/features/team_managment/projects_management/data/repositories/projects_management_repository_impl.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/repositories/projects_management_repository.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/usecases/get_completed_project_details_usecase.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/usecases/get_project_dashboard_usecase.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/usecases/get_project_details_usecase.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/usecases/get_projects_usecase.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/usecases/get_team_settings_usecase.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/usecases/change_leader_usecase.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/usecases/delete_team_usecase.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/usecases/send_join_request_usecase.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/usecases/submit_project_as_complete_usecase.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_bloc.dart';

void initProjectsManagement() {
  // Data sources
  sl.registerLazySingleton<ProjectsManagementRemoteDataSource>(
    () => ProjectsManagementRemoteDataSourceImpl(apiClient: sl()),
  );

  // Repository
  sl.registerLazySingleton<ProjectsManagementRepository>(
    () => ProjectsManagementRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton<GetProjectsUseCase>(
    () => GetProjectsUseCase(repository: sl()),
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

  sl.registerLazySingleton<ChangeLeaderUseCase>(
    () => ChangeLeaderUseCase(repository: sl()),
  );

  sl.registerLazySingleton<DeleteTeamUseCase>(
    () => DeleteTeamUseCase(repository: sl()),
  );

  sl.registerLazySingleton<SendJoinRequestUseCase>(
    () => SendJoinRequestUseCase(repository: sl()),
  );

  // Feature Bloc
  sl.registerLazySingleton<ProjectsFeatureBloc>(
    () => ProjectsFeatureBloc(
      getProjectsUseCase: sl(),
      getProjectDashboardUseCase: sl(),
      getProjectDetailsUseCase: sl(),
      getCompletedProjectDetailsUseCase: sl(),
      getTeamSettingsUseCase: sl(),
      submitProjectAsCompleteUseCase: sl(),
      changeLeaderUseCase: sl(),
      deleteTeamUseCase: sl(),
      chatRepository: sl(),
    ),
  );
}
