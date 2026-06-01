import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/feature/team_evaluation/domain/repositories/team_evaluation_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SubmitEvaluationsUseCase
    implements UseCase<String, SubmitEvaluationsParams> {
  final TeamEvaluationRepository repository;

  SubmitEvaluationsUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(SubmitEvaluationsParams params) async {
    return await repository.submitEvaluations(params.teamId, params.evaluations);
  }
}

class SubmitEvaluationsParams extends Equatable {
  final int teamId;
  final List<Map<String, dynamic>> evaluations;

  const SubmitEvaluationsParams({
    required this.teamId,
    required this.evaluations,
  });

  @override
  List<Object?> get props => [teamId, evaluations];
}
