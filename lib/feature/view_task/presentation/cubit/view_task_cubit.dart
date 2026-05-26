import 'package:bridge_x/feature/view_task/domain/usecases/get_view_task_usecase.dart';
import 'package:bridge_x/feature/view_task/presentation/cubit/view_task_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewTaskCubit extends Cubit<ViewTaskState> {
  final GetViewTaskUseCase _useCase;
  int? _projectId;

  ViewTaskCubit({required GetViewTaskUseCase useCase})
      : _useCase = useCase,
        super(const ViewTaskInitial());

  Future<void> loadTasks(int projectId) async {
    _projectId = projectId;
    emit(const ViewTaskLoading());
    final result = await _useCase(GetViewTaskParams(projectId: projectId));
    if (isClosed) return;
    result.fold(
      (failure) => emit(ViewTaskError(failure.message)),
      (data) => emit(ViewTaskLoaded(data)),
    );
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

    final result = await _useCase(GetViewTaskParams(projectId: projectId));
    if (isClosed) return;
    result.fold(
      (failure) => emit(ViewTaskError(failure.message)),
      (data) => emit(ViewTaskLoaded(data)),
    );
  }

  void retry() {
    final projectId = _projectId;
    if (projectId != null) loadTasks(projectId);
  }
}
