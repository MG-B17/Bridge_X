import 'package:bridge_x/feature/create_task/domain/repositories/create_task_repository.dart';
import 'package:bridge_x/feature/create_task/domain/usecases/create_task_usecase.dart';
import 'package:bridge_x/feature/create_task/presentation/cubit/create_task_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  final CreateTaskUseCase _createTaskUseCase;
  final CreateTaskRepository _repository;

  CreateTaskCubit({
    required CreateTaskUseCase createTaskUseCase,
    required CreateTaskRepository repository,
  })  : _createTaskUseCase = createTaskUseCase,
        _repository = repository,
        super(const CreateTaskInitial());

  Future<void> loadMembers(int projectId) async {
    emit(const CreateTaskMembersLoading());
    final result = await _repository.getTeamMembers(projectId);
    result.fold(
      (failure) => emit(CreateTaskError(failure.message)),
      (members) => emit(CreateTaskReady(members: members)),
    );
  }

  void selectMember(int programmerId) {
    final current = state;
    if (current is CreateTaskReady) {
      emit(current.copyWith(selectedMemberId: programmerId));
    }
  }

  void setPriority(int priority) {
    final current = state;
    if (current is CreateTaskReady) {
      emit(current.copyWith(priority: priority));
    }
  }

  void addTag(String tag) {
    final current = state;
    if (current is CreateTaskReady) {
      if (tag.isNotEmpty && !current.tags.contains(tag)) {
        emit(current.copyWith(tags: [...current.tags, tag]));
      }
    }
  }

  void removeTag(String tag) {
    final current = state;
    if (current is CreateTaskReady) {
      emit(current.copyWith(tags: current.tags.where((t) => t != tag).toList()));
    }
  }

  Future<void> submitTask({
    required int projectId,
    required String title,
    required String description,
    required String deadline,
    String? gitLink,
  }) async {
    final current = state;
    if (current is! CreateTaskReady) return;
    if (state is CreateTaskLoading) return;

    final memberId = current.selectedMemberId;
    if (memberId == null) return;

    emit(const CreateTaskLoading());

    final result = await _createTaskUseCase(CreateTaskParams(
      projectId: projectId,
      title: title,
      description: description,
      programmerId: memberId,
      deadline: deadline,
      priority: current.priority,
      gitLink: gitLink,
      tags: current.tags,
    ));

    result.fold(
      (failure) => emit(CreateTaskError(failure.message)),
      (task) => emit(CreateTaskSuccess(task)),
    );
  }
}
