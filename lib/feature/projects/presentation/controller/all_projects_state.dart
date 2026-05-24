import 'package:bridge_x/feature/projects/domain/entities/all_projects_entity.dart';
import 'package:equatable/equatable.dart';

sealed class AllProjectsState extends Equatable {
  final int selectedFilter;

  const AllProjectsState({this.selectedFilter = 0});

  @override
  List<Object?> get props => [selectedFilter];
}

class AllProjectsInitial extends AllProjectsState {
  const AllProjectsInitial({super.selectedFilter = 0});
}

class AllProjectsLoading extends AllProjectsState {
  final AllProjectsEntity? placeholderData;

  const AllProjectsLoading({this.placeholderData, super.selectedFilter = 0});

  @override
  List<Object?> get props => [placeholderData, selectedFilter];
}

class AllProjectsLoaded extends AllProjectsState {
  final AllProjectsEntity data;

  const AllProjectsLoaded(this.data, {super.selectedFilter = 0});

  @override
  List<Object?> get props => [data, selectedFilter];
}

class AllProjectsLoadingMore extends AllProjectsState {
  final AllProjectsEntity data;

  const AllProjectsLoadingMore(this.data, {super.selectedFilter = 0});

  @override
  List<Object?> get props => [data, selectedFilter];
}

class AllProjectsRefreshing extends AllProjectsState {
  final AllProjectsEntity data;

  const AllProjectsRefreshing(this.data, {super.selectedFilter = 0});

  @override
  List<Object?> get props => [data, selectedFilter];
}

class AllProjectsFailure extends AllProjectsState {
  final String errorMessage;
  final AllProjectsEntity? lastData;

  const AllProjectsFailure(this.errorMessage, {this.lastData, super.selectedFilter = 0});

  @override
  List<Object?> get props => [errorMessage, lastData, selectedFilter];
}
