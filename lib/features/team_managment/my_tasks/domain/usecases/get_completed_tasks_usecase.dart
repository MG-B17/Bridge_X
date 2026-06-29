import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/team_managment/my_tasks/domain/entities/completed_tasks_entity.dart';
import 'package:bridge_x/features/team_managment/my_tasks/domain/repositories/my_tasks_repository.dart';
import 'package:dartz/dartz.dart';

class GetCompletedTasksUseCase
    implements UseCase<CompletedTasksEntity, NoParams> {
  final MyTasksRepository repository;

  GetCompletedTasksUseCase({required this.repository});

  @override
  Future<Either<Failure, CompletedTasksEntity>> call(NoParams params) async {
    return await repository.getCompletedTasks();
  }
}
