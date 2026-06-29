import 'package:bridge_x/features/team_managment/projects_management/domain/usecases/get_team_settings_usecase.dart';
import 'package:bridge_x/features/team_managment/task_management/domain/usecases/create_task_usecase.dart';
import 'package:bridge_x/features/team_managment/task_management/presentation/bloc/create_task/create_task_state.dart';
import 'package:bridge_x/features/team_managment/utils/task_strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  final CreateTaskUseCase _createTaskUseCase;
  final GetTeamSettingsUseCase _getTeamSettingsUseCase;

  CreateTaskCubit({
    required CreateTaskUseCase createTaskUseCase,
    required GetTeamSettingsUseCase getTeamSettingsUseCase,
  })  : _createTaskUseCase = createTaskUseCase,
        _getTeamSettingsUseCase = getTeamSettingsUseCase,
        super(const CreateTaskInitial());

  Future<void> loadMembers(int projectId) async {
    emit(const CreateTaskMembersLoading());
    try {
      final result = await _getTeamSettingsUseCase(
        GetTeamSettingsParams(projectId: projectId),
      );
      if (isClosed) return;
      result.fold(
        (failure) => emit(CreateTaskError(failure.message)),
        (settings) => emit(CreateTaskReady(members: settings.members)),
      );
    } catch (_) {
      if (!isClosed) emit(CreateTaskError(TaskStrings.failedToLoadMembers));
    }
  }

  void selectMember(int programmerId) {
    final current = state;
    if (current is CreateTaskReady) {
      emit(current.copyWith(selectedMemberId: programmerId));
    }
  }

  void setPriority(String priority) {
    final current = state;
    if (current is CreateTaskReady) {
      emit(current.copyWith(priority: priority));
    }
  }

  void setDate(DateTime date) {
    final current = state;
    if (current is CreateTaskReady) {
      emit(current.copyWith(selectedDate: date));
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
    required int teamId,
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

    try {
      final result = await _createTaskUseCase(CreateTaskParams(
        teamId: teamId,
        title: title,
        description: description,
        programmerId: memberId,
        deadline: deadline,
        priority: current.priority,
        gitLink: gitLink,
        tags: current.tags,
      ));

      if (isClosed) return;

      result.fold(
        (failure) => emit(CreateTaskError(failure.message)),
        (task) => emit(CreateTaskSuccess(task)),
      );
    } catch (_) {
      if (!isClosed) emit(CreateTaskError(TaskStrings.somethingWentWrong));
    }
  }
}
