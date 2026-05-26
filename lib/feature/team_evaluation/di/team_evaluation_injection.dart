import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/feature/team_evaluation/data/datasources/team_evaluation_remote_data_source.dart';
import 'package:bridge_x/feature/team_evaluation/data/repositories/team_evaluation_repository_impl.dart';
import 'package:bridge_x/feature/team_evaluation/domain/repositories/team_evaluation_repository.dart';
import 'package:bridge_x/feature/team_evaluation/domain/usecases/get_team_members_usecase.dart';
import 'package:bridge_x/feature/team_evaluation/domain/usecases/submit_evaluations_usecase.dart';
import 'package:bridge_x/feature/team_evaluation/presentation/cubit/team_evaluation_cubit.dart';

void initTeamEvaluation() {
  sl.registerLazySingleton<TeamEvaluationRemoteDataSource>(
    () => TeamEvaluationRemoteDataSourceImpl(apiClient: sl()),
  );

  sl.registerLazySingleton<TeamEvaluationRepository>(
    () => TeamEvaluationRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<GetTeamMembersUseCase>(
    () => GetTeamMembersUseCase(repository: sl()),
  );

  sl.registerLazySingleton<SubmitEvaluationsUseCase>(
    () => SubmitEvaluationsUseCase(repository: sl()),
  );

  sl.registerFactory<TeamEvaluationCubit>(
    () => TeamEvaluationCubit(
      getTeamMembersUseCase: sl(),
      submitEvaluationsUseCase: sl(),
    ),
  );
}
