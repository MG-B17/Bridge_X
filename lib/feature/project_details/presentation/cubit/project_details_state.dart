import 'package:bridge_x/feature/project_details/domain/entities/project_details_entity.dart';
import 'package:equatable/equatable.dart';

sealed class ProjectDetailsState extends Equatable {
  const ProjectDetailsState();

  @override
  List<Object?> get props => [];
}

class ProjectDetailsInitial extends ProjectDetailsState {
  const ProjectDetailsInitial();
}

class ProjectDetailsLoading extends ProjectDetailsState {
  final ProjectDetailsEntity? placeholderData;

  const ProjectDetailsLoading({this.placeholderData});

  @override
  List<Object?> get props => [placeholderData];
}

class ProjectDetailsLoaded extends ProjectDetailsState {
  final ProjectDetailsEntity data;

  const ProjectDetailsLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class ProjectDetailsRefreshing extends ProjectDetailsState {
  final ProjectDetailsEntity data;

  const ProjectDetailsRefreshing(this.data);

  @override
  List<Object?> get props => [data];
}

class ProjectDetailsFailure extends ProjectDetailsState {
  final String errorMessage;

  const ProjectDetailsFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
