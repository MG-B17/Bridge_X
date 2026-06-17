import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/create_team/domain/entity/create_team_entity.dart';
import 'package:bridge_x/feature/create_team/domain/entity/create_team_params.dart';
import 'package:bridge_x/feature/create_team/domain/entity/programmer_search_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CreateTeamRepo {
  Future<Either<Failure, CreateTeamEntity>> createTeam({
    required CreateTeamParams request,
  });

  Future<Either<Failure, List<ProgrammerSearchEntity>>> searchProgrammers(
    String query,
  );
}
