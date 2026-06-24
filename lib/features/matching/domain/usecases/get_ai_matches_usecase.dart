import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/matching/domain/entities/ai_match_entity.dart';
import 'package:bridge_x/features/matching/domain/repositories/matching_repository.dart';
import 'package:dartz/dartz.dart';

class GetAiMatchesUseCase implements UseCase<AiMatchEntity, NoParams> {
  final MatchingRepository repository;

  GetAiMatchesUseCase({required this.repository});

  @override
  Future<Either<Failure, AiMatchEntity>> call(NoParams params) async {
    return await repository.getAiMatches();
  }
}
