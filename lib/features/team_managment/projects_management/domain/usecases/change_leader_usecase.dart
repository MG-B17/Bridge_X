import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/dashboard/change_leader_entity.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/repositories/projects_management_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ChangeLeaderParams extends Equatable {
  final int projectId;
  final int userId;

  const ChangeLeaderParams({
    required this.projectId,
    required this.userId,
  });

  @override
  List<Object?> get props => [projectId, userId];
}

class ChangeLeaderUseCase
    implements UseCase<ChangeLeaderEntity, ChangeLeaderParams> {
  final ProjectsManagementRepository repository;

  ChangeLeaderUseCase({required this.repository});

  @override
  Future<Either<Failure, ChangeLeaderEntity>> call(
    ChangeLeaderParams params,
  ) {
    return repository.changeLeader(
      projectId: params.projectId,
      userId: params.userId,
    );
  }
}
