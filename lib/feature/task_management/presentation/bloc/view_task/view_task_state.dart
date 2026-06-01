import 'package:bridge_x/feature/task_management/domain/entities/view_task_entity.dart';
import 'package:equatable/equatable.dart';

sealed class ViewTaskState extends Equatable {
  const ViewTaskState();
  @override
  List<Object?> get props => [];
}

class ViewTaskInitial extends ViewTaskState {
  const ViewTaskInitial();
}

class ViewTaskLoading extends ViewTaskState {
  const ViewTaskLoading();
}

class ViewTaskLoaded extends ViewTaskState {
  final ViewTaskEntity data;
  const ViewTaskLoaded(this.data);
  @override
  List<Object?> get props => [data];
}

class ViewTaskRefreshing extends ViewTaskState {
  final ViewTaskEntity data;
  const ViewTaskRefreshing(this.data);
  @override
  List<Object?> get props => [data];
}

class ViewTaskError extends ViewTaskState {
  final String message;
  const ViewTaskError(this.message);
  @override
  List<Object?> get props => [message];
}
