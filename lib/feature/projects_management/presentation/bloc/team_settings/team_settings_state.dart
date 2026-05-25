import 'package:bridge_x/feature/projects_management/domain/entities/dashboard/team_settings_entity.dart';
import 'package:equatable/equatable.dart';

sealed class TeamSettingsState extends Equatable {
  const TeamSettingsState();

  @override
  List<Object?> get props => [];
}

class TeamSettingsInitial extends TeamSettingsState {
  const TeamSettingsInitial();
}

class TeamSettingsLoading extends TeamSettingsState {
  const TeamSettingsLoading();
}

class TeamSettingsLoaded extends TeamSettingsState {
  final TeamSettingsEntity teamSettings;

  const TeamSettingsLoaded({required this.teamSettings});

  @override
  List<Object?> get props => [teamSettings];
}

class TeamSettingsRefreshing extends TeamSettingsState {
  final TeamSettingsEntity teamSettings;

  const TeamSettingsRefreshing({required this.teamSettings});

  @override
  List<Object?> get props => [teamSettings];
}

class TeamSettingsFailure extends TeamSettingsState {
  final String message;

  const TeamSettingsFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
