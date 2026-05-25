import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/feature/create_task/domain/entities/create_task_entity.dart';
import 'package:bridge_x/feature/create_task/domain/repositories/create_task_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CreateTaskParams extends Equatable {
  final int projectId;
  final String title;
  final String description;
  final int programmerId;
  final String deadline;
  final int priority;
  final String? gitLink;
  final List<String> tags;

  const CreateTaskParams({
    required this.projectId,
    required this.title,
    required this.description,
    required this.programmerId,
    required this.deadline,
    required this.priority,
    this.gitLink,
    required this.tags,
  });

  @override
  List<Object?> get props => [projectId, title, description, programmerId, deadline, priority, gitLink, tags];
}

class CreateTaskUseCase implements UseCase<CreateTaskEntity, CreateTaskParams> {
  final CreateTaskRepository repository;

  CreateTaskUseCase({required this.repository});

  @override
  Future<Either<Failure, CreateTaskEntity>> call(CreateTaskParams params) {
    return repository.createTask(
      projectId: params.projectId,
      title: params.title,
      description: params.description,
      programmerId: params.programmerId,
      deadline: params.deadline,
      priority: params.priority,
      gitLink: params.gitLink,
      tags: params.tags,
    );
  }
}
