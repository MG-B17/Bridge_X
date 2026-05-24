import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/project_details/domain/entities/project_details_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProjectDetailsRepository {
  Future<Either<Failure, ProjectDetailsEntity>> getProjectDetails({
    required int projectId,
    required String status,
  });
}
