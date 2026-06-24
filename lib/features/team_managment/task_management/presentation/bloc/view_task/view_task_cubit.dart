import 'package:bridge_x/features/team_managment/task_management/domain/usecases/get_tasks_usecase.dart';
import 'package:bridge_x/features/team_managment/task_management/presentation/bloc/view_task/view_task_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewTaskCubit extends Cubit<ViewTaskState> {
  final GetTasksUseCase _useCase;
  int? _projectId;

  ViewTaskCubit({required GetTasksUseCase useCase})
      : _useCase = useCase,
        super(const ViewTaskInitial());

  Future<void> loadTasks(int projectId) async {
    _projectId = projectId;
    emit(const ViewTaskLoading());
    try {
      final result = await _useCase(GetTasksParams(projectId: projectId));
      if (isClosed) return;
      result.fold(
        (failure) => emit(ViewTaskError(failure.message)),
        (data) => emit(ViewTaskLoaded(data)),
      );
    } catch (e) {
      if (isClosed) return;
      emit(ViewTaskError(e.toString()));
    }
  }

  Future<void> refresh() async {
    final projectId = _projectId;
    if (projectId == null) return;
    if (state is ViewTaskLoading || state is ViewTaskRefreshing) return;

    final current = state;
    if (current is ViewTaskLoaded) {
      emit(ViewTaskRefreshing(current.data));
    } else {
      emit(const ViewTaskLoading());
    }

    try {
      final result = await _useCase(GetTasksParams(projectId: projectId));
      if (isClosed) return;
      result.fold(
        (failure) {
          final currentState = state;
          if (currentState is ViewTaskRefreshing) {
            emit(ViewTaskLoaded(currentState.data, refreshError: failure.message));
          } else {
            emit(ViewTaskError(failure.message));
          }
        },
        (data) => emit(ViewTaskLoaded(data)),
      );
    } catch (e) {
      if (isClosed) return;
      final currentState = state;
      if (currentState is ViewTaskRefreshing) {
        emit(ViewTaskLoaded(currentState.data, refreshError: e.toString()));
      } else {
        emit(ViewTaskError(e.toString()));
      }
    }
  }

  void retry() {
    final projectId = _projectId;
    if (projectId != null) loadTasks(projectId);
  }
}
