import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/projects/domain/entities/all_projects_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AllProjectsRepo {
  Future<Either<Failure, AllProjectsEntity>> getAllProjects({int page = 1});
  Future<Either<Failure, AllProjectsEntity>> getCachedProjects();
}
