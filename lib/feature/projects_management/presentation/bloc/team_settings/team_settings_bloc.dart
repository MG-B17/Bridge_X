import 'package:bridge_x/feature/projects_management/domain/entities/dashboard/team_settings_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/usecases/get_team_settings_usecase.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/team_settings/team_settings_event.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/team_settings/team_settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeamSettingsBloc extends Bloc<TeamSettingsEvent, TeamSettingsState> {
  final GetTeamSettingsUseCase getTeamSettingsUseCase;

  static final TeamSettingsEntity _placeholder = TeamSettingsEntity(
    teamName: '',
    githubLink: '',
    projectDescription: '',
    members: const [],
  );

  TeamSettingsBloc({required this.getTeamSettingsUseCase})
      : super(const TeamSettingsInitial()) {
    on<LoadTeamSettings>(_onLoadTeamSettings);
    on<RefreshTeamSettings>(_onRefreshTeamSettings);
  }

  Future<void> _onLoadTeamSettings(
    LoadTeamSettings event,
    Emitter<TeamSettingsState> emit,
  ) async {
    if (state is TeamSettingsLoading) return;

    emit(const TeamSettingsLoading());

    final result = await getTeamSettingsUseCase(
      GetTeamSettingsParams(projectId: event.projectId),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(TeamSettingsFailure(message: failure.message)),
      (data) => emit(TeamSettingsLoaded(teamSettings: data)),
    );
  }

  Future<void> _onRefreshTeamSettings(
    RefreshTeamSettings event,
    Emitter<TeamSettingsState> emit,
  ) async {
    if (state is TeamSettingsLoading) return;

    final currentData = switch (state) {
      TeamSettingsLoaded(:final teamSettings) => teamSettings,
      _ => _placeholder,
    };

    emit(TeamSettingsRefreshing(teamSettings: currentData));

    final result = await getTeamSettingsUseCase(
      GetTeamSettingsParams(projectId: event.projectId),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(TeamSettingsFailure(message: failure.message)),
      (data) => emit(TeamSettingsLoaded(teamSettings: data)),
    );
  }
}
