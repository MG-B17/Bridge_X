import 'package:equatable/equatable.dart';

sealed class TeamSettingsEvent extends Equatable {
  const TeamSettingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadTeamSettings extends TeamSettingsEvent {
  final int projectId;

  const LoadTeamSettings(this.projectId);

  @override
  List<Object?> get props => [projectId];
}

class RefreshTeamSettings extends TeamSettingsEvent {
  final int projectId;

  const RefreshTeamSettings(this.projectId);

  @override
  List<Object?> get props => [projectId];
}
