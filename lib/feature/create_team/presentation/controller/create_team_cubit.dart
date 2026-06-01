import 'package:bridge_x/core/utils/enum/create_team_status_enum.dart';
import 'package:bridge_x/feature/create_team/domain/entity/create_team_params.dart';
import 'package:bridge_x/feature/create_team/domain/usecases/create_team_usecase.dart';
import 'package:bridge_x/feature/create_team/presentation/controller/create_team_state.dart';
import 'package:bridge_x/feature/create_team/presentation/utils/create_team_mapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTeamCubit extends Cubit<CreateTeamState> {
  final CreateTeamUseCase createTeamUseCase;

  CreateTeamCubit({required this.createTeamUseCase}) : super(const CreateTeamState());

  void changeTeamType({required int index}) {
    emit(state.copyWith(selectedTeamType: index, status: CreateTeamStatus.initial));
  }

  void changeCategory({required int index}) {
    emit(state.copyWith(selectedCategory: index, status: CreateTeamStatus.initial));
  }

  void addRole({required String role}) {
    final updatedRoles = List<String>.from(state.selectedRoles);
    if (!updatedRoles.contains(role)) {
      updatedRoles.add(role);
      emit(state.copyWith(
        selectedRoles: updatedRoles,
        status: CreateTeamStatus.initial,
        showRolesError: false,
      ));
    }
  }

  void removeRole({required String role}) {
    final updatedRoles = List<String>.from(state.selectedRoles);
    if (updatedRoles.remove(role)) {
      final showRolesError = updatedRoles.isEmpty;
      emit(state.copyWith(
        selectedRoles: updatedRoles,
        status: CreateTeamStatus.initial,
        showRolesError: showRolesError,
      ));
    }
  }

  void setShowRolesError(bool show) {
    emit(state.copyWith(showRolesError: show, status: CreateTeamStatus.initial));
  }

  void resetStatus() {
    emit(state.copyWith(status: CreateTeamStatus.initial, errorMessage: null));
  }

  Future<void> createTeam({
    required String name,
    required String description,
    required String githubUrl,
  }) async {
    emit(state.copyWith(status: CreateTeamStatus.loading));

    final categoryString = CreateTeamMapper.mapCategoryIndexToString(state.selectedCategory);
    final tracks = CreateTeamMapper.mapSelectedRoles(state.selectedRoles);

    final request = CreateTeamParams(
      name: name.trim(),
      description: description.trim(),
      isPublic: state.selectedTeamType == 1,
      githubUrl: githubUrl.trim(),
      categories: [categoryString],
      requiredTracks: tracks,
    );

    final result = await createTeamUseCase(request);
    result.fold(
      (failure) =>
          emit(state.copyWith(status: CreateTeamStatus.failure, errorMessage: failure.message)),
      (entity) => emit(state.copyWith(status: CreateTeamStatus.success, entity: entity)),
    );
  }
}
