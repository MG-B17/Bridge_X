import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/features/invitaions/data/datasource/invitaions_mock_datasource.dart';
import 'package:bridge_x/features/invitaions/data/datasource/invitaions_remote_datasource.dart';
import 'package:bridge_x/features/invitaions/data/datasource/join_requests_remote_datasource.dart';
import 'package:bridge_x/features/invitaions/data/repositories/invitaions_repository_impl.dart';
import 'package:bridge_x/features/invitaions/domain/repositories/invitaions_repository.dart';
import 'package:bridge_x/features/invitaions/domain/usecases/accept_invitation_usecase.dart';
import 'package:bridge_x/features/invitaions/domain/usecases/decline_invitation_usecase.dart';
import 'package:bridge_x/features/invitaions/domain/usecases/get_invitation_details_usecase.dart';
import 'package:bridge_x/features/invitaions/domain/usecases/get_invitaions_usecase.dart';
import 'package:bridge_x/features/invitaions/domain/usecases/get_join_request_details_usecase.dart';
import 'package:bridge_x/features/invitaions/domain/usecases/get_join_requests_usecase.dart';
import 'package:bridge_x/features/invitaions/domain/usecases/get_my_join_requests_usecase.dart';
import 'package:bridge_x/features/invitaions/presentation/cubit/invitaions_cubit.dart';

void initInvitaions() {
  // Data sources
  sl.registerLazySingleton<InvitaionsMockDataSource>(
    () => InvitaionsMockDataSource(),
  );
  sl.registerLazySingleton<InvitaionsRemoteDataSource>(
    () => InvitaionsRemoteDataSourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<JoinRequestsRemoteDataSource>(
    () => JoinRequestsRemoteDataSourceImpl(apiClient: sl()),
  );

  // Repositories
  sl.registerLazySingleton<InvitaionsRepository>(
    () => InvitaionsRepositoryImpl(
      remoteDataSource: sl(),
      joinRequestsRemoteDataSource: sl(),
      mockDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Usecases
  sl.registerLazySingleton<GetInvitaionsUseCase>(
    () => GetInvitaionsUseCase(repository: sl()),
  );
  sl.registerLazySingleton<GetInvitationDetailsUseCase>(
    () => GetInvitationDetailsUseCase(repository: sl()),
  );
  sl.registerLazySingleton<AcceptInvitationUseCase>(
    () => AcceptInvitationUseCase(repository: sl()),
  );
  sl.registerLazySingleton<DeclineInvitationUseCase>(
    () => DeclineInvitationUseCase(repository: sl()),
  );
  sl.registerLazySingleton<GetJoinRequestsUseCase>(
    () => GetJoinRequestsUseCase(repository: sl()),
  );
  sl.registerLazySingleton<GetMyJoinRequestsUseCase>(
    () => GetMyJoinRequestsUseCase(repository: sl()),
  );
  sl.registerLazySingleton<GetJoinRequestDetailsUseCase>(
    () => GetJoinRequestDetailsUseCase(repository: sl()),
  );

  // Cubits
  sl.registerFactory<InvitaionsCubit>(
    () => InvitaionsCubit(
      getInvitaionsUseCase: sl(),
      getJoinRequestsUseCase: sl(),
      getInvitationDetailsUseCase: sl(),
      getJoinRequestDetailsUseCase: sl(),
      acceptInvitationUseCase: sl(),
      declineInvitationUseCase: sl(),
      repository: sl(),
    ),
  );
}
