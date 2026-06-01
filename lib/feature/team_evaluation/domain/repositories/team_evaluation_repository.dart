import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/team_evaluation/domain/entities/team_basic_details_entity.dart';
import 'package:dartz/dartz.dart';

abstract class TeamEvaluationRepository {
  Future<Either<Failure, TeamBasicDetailsEntity>> getTeamBasicDetails(int teamId);
  Future<Either<Failure, String>> submitEvaluations(
    int teamId,
    List<Map<String, dynamic>> evaluations,
  );
}
