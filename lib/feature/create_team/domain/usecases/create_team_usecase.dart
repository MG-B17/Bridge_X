import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/feature/create_team/domain/entity/create_team_entity.dart';
import 'package:bridge_x/feature/create_team/domain/entity/create_team_params.dart';
import 'package:bridge_x/feature/create_team/domain/repo/create_team_repo.dart';
import 'package:dartz/dartz.dart';

class CreateTeamUseCase implements UseCase<CreateTeamEntity, CreateTeamParams> {
  final CreateTeamRepo repository;

  CreateTeamUseCase({required this.repository});

  @override
  Future<Either<Failure, CreateTeamEntity>> call(CreateTeamParams params) async {
    return await repository.createTeam(request: params);
  }
}
