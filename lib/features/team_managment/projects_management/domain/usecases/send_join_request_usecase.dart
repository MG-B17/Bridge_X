import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/dashboard/send_join_request_entity.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/repositories/projects_management_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SendJoinRequestParams extends Equatable {
  final int teamId;

  const SendJoinRequestParams({required this.teamId});

  @override
  List<Object?> get props => [teamId];
}

class SendJoinRequestUseCase
    implements UseCase<SendJoinRequestEntity, SendJoinRequestParams> {
  final ProjectsManagementRepository repository;

  SendJoinRequestUseCase({required this.repository});

  @override
  Future<Either<Failure, SendJoinRequestEntity>> call(
    SendJoinRequestParams params,
  ) {
    return repository.sendJoinRequest(teamId: params.teamId);
  }
}
