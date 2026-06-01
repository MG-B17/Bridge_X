import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/levels/domain/entities/level_entity.dart';
import 'package:bridge_x/feature/levels/domain/repositories/level_repository.dart';
import 'package:dartz/dartz.dart';

class GetLevelUseCase {
  final LevelRepository repository;

  GetLevelUseCase({required this.repository});

  Future<Either<Failure, LevelEntity>> call() {
    return repository.getLevel();
  }
}
