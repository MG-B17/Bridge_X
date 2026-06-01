import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/levels/domain/entities/level_entity.dart';
import 'package:dartz/dartz.dart';

abstract class LevelRepository {
  Future<Either<Failure, LevelEntity>> getLevel();
}
