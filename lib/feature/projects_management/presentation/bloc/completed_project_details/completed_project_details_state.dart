import 'package:bridge_x/feature/projects_management/domain/entities/details/completed_project_details_entity.dart';
import 'package:equatable/equatable.dart';

sealed class CompletedProjectDetailsState extends Equatable {
  const CompletedProjectDetailsState();

  @override
  List<Object?> get props => [];
}

class CompletedProjectDetailsInitial extends CompletedProjectDetailsState {
  const CompletedProjectDetailsInitial();
}

class CompletedProjectDetailsLoading extends CompletedProjectDetailsState {
  final CompletedProjectDetailsEntity? placeholderData;

  const CompletedProjectDetailsLoading({this.placeholderData});

  @override
  List<Object?> get props => [placeholderData];
}

class CompletedProjectDetailsLoaded extends CompletedProjectDetailsState {
  final CompletedProjectDetailsEntity data;

  const CompletedProjectDetailsLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class CompletedProjectDetailsRefreshing extends CompletedProjectDetailsState {
  final CompletedProjectDetailsEntity data;

  const CompletedProjectDetailsRefreshing(this.data);

  @override
  List<Object?> get props => [data];
}

class CompletedProjectDetailsFailure extends CompletedProjectDetailsState {
  final String errorMessage;

  const CompletedProjectDetailsFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
