import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/matching/domain/entities/ai_match_entity.dart';
import 'package:dartz/dartz.dart';

abstract class MatchingRepository {
  Future<Either<Failure, AiMatchEntity>> getAiMatches();
}
