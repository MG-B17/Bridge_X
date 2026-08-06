import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/features/team_managment/team_evaluation/domain/entities/team_basic_details_entity.dart';
import 'package:dartz/dartz.dart';

abstract class TeamEvaluationRepository {
  Future<Either<Failure, TeamBasicDetailsEntity>> getTeamBasicDetails(
    int projectId,
  );
  Future<Either<Failure, String>> submitEvaluations(
    int projectId,
    List<Map<String, dynamic>> evaluations,
  );
}
