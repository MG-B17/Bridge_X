import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/team_managment/my_tasks/domain/entities/active_tasks_entity.dart';
import 'package:bridge_x/features/team_managment/my_tasks/domain/repositories/my_tasks_repository.dart';
import 'package:dartz/dartz.dart';

class GetActiveTasksUseCase implements UseCase<ActiveTasksEntity, NoParams> {
  final MyTasksRepository repository;

  GetActiveTasksUseCase({required this.repository});

  @override
  Future<Either<Failure, ActiveTasksEntity>> call(NoParams params) async {
    return await repository.getActiveTasks();
  }
}
