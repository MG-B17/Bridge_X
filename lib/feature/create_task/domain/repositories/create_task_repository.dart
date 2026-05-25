import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/create_task/domain/entities/create_task_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/dashboard/team_member_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CreateTaskRepository {
  Future<Either<Failure, CreateTaskEntity>> createTask({
    required int projectId,
    required String title,
    required String description,
    required int programmerId,
    required String deadline,
    required int priority,
    String? gitLink,
    required List<String> tags,
  });

  Future<Either<Failure, List<TeamMemberEntity>>> getTeamMembers(int projectId);
}
