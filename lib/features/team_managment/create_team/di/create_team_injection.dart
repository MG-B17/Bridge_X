import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/features/team_managment/create_team/data/remote_data/create_team_remote_data.dart';
import 'package:bridge_x/features/team_managment/create_team/data/repo_implement/create_team_repo_implement.dart';
import 'package:bridge_x/features/team_managment/create_team/domain/repo/create_team_repo.dart';
import 'package:bridge_x/features/team_managment/create_team/domain/usecases/create_team_usecase.dart';
import 'package:bridge_x/features/team_managment/create_team/domain/usecases/search_programmers_usecase.dart';
import 'package:bridge_x/features/team_managment/create_team/presentation/controller/create_team_cubit.dart';

void initCreateTeam() {
  // Remote Data Source
  sl.registerLazySingleton<CreateTeamRemoteData>(
    () => CreateTeamRemoteDataImpl(apiClient: sl()),
  );

  // Repository
  sl.registerLazySingleton<CreateTeamRepo>(
    () => CreateTeamRepoImplement(remoteDataSource: sl(), networkInfo: sl()),
  );

  // UseCases
  sl.registerLazySingleton<CreateTeamUseCase>(
    () => CreateTeamUseCase(repository: sl()),
  );
  sl.registerLazySingleton<SearchProgrammersUseCase>(
    () => SearchProgrammersUseCase(repository: sl()),
  );

  // Cubit
  sl.registerFactory<CreateTeamCubit>(
    () => CreateTeamCubit(
      createTeamUseCase: sl(),
      createTeamChatRoomUseCase: sl(),
      searchProgrammersUseCase: sl(),
    ),
  );
}
