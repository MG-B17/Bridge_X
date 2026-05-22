import 'package:bridge_x/feature/dashboard/domain/entities/dashboard_entity.dart';
import 'package:equatable/equatable.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final DashboardEntity dashboard;
  final String? errorMessage;

  const DashboardLoaded({required this.dashboard, this.errorMessage});

  @override
  List<Object?> get props => [dashboard, errorMessage];
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError({required this.message});

  @override
  List<Object?> get props => [message];
}

class DashboardRefreshing extends DashboardState {
  final DashboardEntity dashboard;

  const DashboardRefreshing({required this.dashboard});

  @override
  List<Object?> get props => [dashboard];
}
