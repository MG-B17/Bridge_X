import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/team_managment/my_tasks/domain/entities/active_tasks_entity.dart';
import 'package:bridge_x/features/team_managment/my_tasks/domain/entities/completed_tasks_entity.dart';
import 'package:bridge_x/features/team_managment/my_tasks/domain/usecases/get_active_tasks_usecase.dart';
import 'package:bridge_x/features/team_managment/my_tasks/domain/usecases/get_completed_tasks_usecase.dart';
import 'package:bridge_x/features/team_managment/my_tasks/domain/usecases/get_task_details_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'my_tasks_state.dart';
import 'task_item_mapper.dart';

class MyTasksCubit extends Cubit<MyTasksState> {
  final GetActiveTasksUseCase getActiveTasksUseCase;
  final GetCompletedTasksUseCase getCompletedTasksUseCase;
  final GetTaskDetailsUseCase getTaskDetailsUseCase;

  bool _isFetching = false;

  MyTasksCubit({
    required this.getActiveTasksUseCase,
    required this.getCompletedTasksUseCase,
    required this.getTaskDetailsUseCase,
  }) : super(const MyTasksInitial());

  Future<void> fetchAllTasks() async {
    if (_isFetching) return;
    _isFetching = true;
    emit(const MyTasksLoading());

    try {
      final results = await Future.wait([
        getActiveTasksUseCase(NoParams()),
        getCompletedTasksUseCase(NoParams()),
      ]);

      final activeResult =
          results[0] as Either<Failure, ActiveTasksEntity>;
      final completedResult =
          results[1] as Either<Failure, CompletedTasksEntity>;

      final active = activeResult.fold<ActiveTasksEntity?>(
        (failure) => null,
        (entity) => entity,
      );
      final completed = completedResult.fold<CompletedTasksEntity?>(
        (failure) => null,
        (entity) => entity,
      );

      if (active == null && completed == null) {
        final activeError = activeResult.fold(
          (f) => f.message,
          (_) => '',
        );
        final completedError = completedResult.fold(
          (f) => f.message,
          (_) => '',
        );
        final combined = [activeError, completedError]
            .where((m) => m.isNotEmpty)
            .join('\n');
        if (!isClosed) {
          emit(MyTasksFailure(combined));
        }
        return;
      }

      final partialFailure = (active == null || completed == null)
          ? (active == null
              ? activeResult.fold((f) => f.message, (_) => '')
              : completedResult.fold((f) => f.message, (_) => ''))
          : null;

      if (!isClosed) {
        emit(MyTasksLoaded(
          activeTasks: active?.activeTasks
                  .map((t) => TaskItemMapper.fromActiveTask(t))
                  .toList() ??
              [],
          completedTasks: completed?.completedTasks
                  .map((t) => TaskItemMapper.fromCompletedTask(t))
                  .toList() ??
              [],
          numOfTasksDone: completed?.numOfTasksDone ?? 0,
          numOfTasksDoneThisWeek: completed?.numOfTasksDoneThisWeek ?? 0,
          partialFailureMessage: partialFailure,
        ));
      }
    } catch (_) {
      if (!isClosed) {
        emit(const MyTasksFailure('Something went wrong'));
      }
    } finally {
      _isFetching = false;
    }
  }

  Future<void> fetchTaskDetails(int taskId) async {
    if (_isFetching) return;
    _isFetching = true;
    emit(const TaskDetailsLoading());

    try {
      final result =
          await getTaskDetailsUseCase(GetTaskDetailsParams(taskId: taskId));
      if (isClosed) return;
      result.fold(
        (failure) => emit(TaskDetailsFailure(failure.message)),
        (entity) => emit(
          TaskDetailsLoaded(TaskItemMapper.fromTaskDetails(entity)),
        ),
      );
    } catch (_) {
      if (!isClosed) {
        emit(const TaskDetailsFailure('Something went wrong'));
      }
    } finally {
      _isFetching = false;
    }
  }
}
