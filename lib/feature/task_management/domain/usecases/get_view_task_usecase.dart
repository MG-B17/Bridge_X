import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/feature/task_management/domain/entities/view_task_entity.dart';
import 'package:bridge_x/feature/task_management/domain/repositories/task_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetViewTaskParams extends Equatable {
  final int projectId;
  final String tasksView;

  const GetViewTaskParams({required this.projectId, this.tasksView = 'my'});

  @override
  List<Object?> get props => [projectId, tasksView];
}

class GetViewTaskUseCase implements UseCase<ViewTaskEntity, GetViewTaskParams> {
  final TaskRepository repository;

  GetViewTaskUseCase({required this.repository});

  @override
  Future<Either<Failure, ViewTaskEntity>> call(GetViewTaskParams params) {
    return repository.getTasks(projectId: params.projectId, tasksView: params.tasksView);
  }
}
