import 'package:bridge_x/feature/profile/domain/entities/profile_dashboard_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileDashboardState extends Equatable {
  const ProfileDashboardState();

  @override
  List<Object?> get props => [];
}

class ProfileDashboardInitial extends ProfileDashboardState {}

class ProfileDashboardLoading extends ProfileDashboardState {}

class ProfileDashboardLoaded extends ProfileDashboardState {
  final ProfileDashboardEntity dashboard;

  const ProfileDashboardLoaded({required this.dashboard});

  @override
  List<Object?> get props => [dashboard];
}

class ProfileDashboardError extends ProfileDashboardState {
  final String message;

  const ProfileDashboardError({required this.message});

  @override
  List<Object?> get props => [message];
}
