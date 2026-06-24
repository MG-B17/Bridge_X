import 'dart:async';
import 'package:bridge_x/core/utils/enum/create_team_status_enum.dart';
import 'package:bridge_x/features/team_managment/create_team/domain/entity/create_team_entity.dart';
import 'package:bridge_x/features/team_managment/create_team/domain/entity/create_team_params.dart';
import 'package:bridge_x/features/team_managment/create_team/domain/entity/programmer_search_entity.dart';
import 'package:bridge_x/features/team_managment/create_team/domain/usecases/create_team_usecase.dart';
import 'package:bridge_x/features/team_managment/create_team/domain/usecases/search_programmers_usecase.dart';
import 'package:bridge_x/features/team_managment/create_team/presentation/controller/create_team_state.dart';
import 'package:bridge_x/features/team_managment/create_team/presentation/utils/create_team_mapper.dart';
// import 'package:bridge_x/features/chat/domain/usecases/create_team_chat_room_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CreateTeamCubit extends Cubit<CreateTeamState> {
  final CreateTeamUseCase createTeamUseCase;
  // final CreateTeamChatRoomUseCase createTeamChatRoomUseCase;
  final SearchProgrammersUseCase searchProgrammersUseCase;

  Timer? _searchTimer;
  String? _searchSequenceToken;

  CreateTeamCubit({
    required this.createTeamUseCase,
    // required this.createTeamChatRoomUseCase,
    required this.searchProgrammersUseCase,
  }) : super(const CreateTeamState());

  void changeTeamType({required int index}) {
    emit(
      state.copyWith(selectedTeamType: index, status: CreateTeamStatus.initial),
    );
  }

  void changeCategory({required int index}) {
    emit(
      state.copyWith(selectedCategory: index, status: CreateTeamStatus.initial),
    );
  }

  void addRole({required String role}) {
    final updatedRoles = List<String>.from(state.selectedRoles);
    if (!updatedRoles.contains(role)) {
      updatedRoles.add(role);
      emit(
        state.copyWith(
          selectedRoles: updatedRoles,
          status: CreateTeamStatus.initial,
          showRolesError: false,
        ),
      );
    }
  }

  void removeRole({required String role}) {
    final updatedRoles = List<String>.from(state.selectedRoles);
    if (updatedRoles.remove(role)) {
      final showRolesError = updatedRoles.isEmpty;
      emit(
        state.copyWith(
          selectedRoles: updatedRoles,
          status: CreateTeamStatus.initial,
          showRolesError: showRolesError,
        ),
      );
    }
  }

  void setShowRolesError(bool show) {
    emit(
      state.copyWith(showRolesError: show, status: CreateTeamStatus.initial),
    );
  }

  void addInvitedMember(String username, [ProgrammerSearchEntity? programmer]) {
    if (username.trim().isEmpty) return;
    final updated = List<String>.from(state.invitedMembers);
    if (!updated.contains(username.trim())) {
      updated.add(username.trim());
      final updatedResults = programmer != null
          ? state.searchResults.where((r) => r.id != programmer.id).toList()
          : state.searchResults.where((r) => r.userName != username.trim()).toList();
      emit(
        state.copyWith(
          invitedMembers: updated,
          searchResults: updatedResults,
          status: CreateTeamStatus.initial,
        ),
      );
    }
  }

  void removeInvitedMember(String identifier) {
    final updated = List<String>.from(state.invitedMembers);
    updated.remove(identifier);
    emit(
      state.copyWith(invitedMembers: updated, status: CreateTeamStatus.initial),
    );
  }

  void setInvitedMembers(List<String> members) {
    emit(
      state.copyWith(
        invitedMembers: members,
        status: CreateTeamStatus.initial,
      ),
    );
  }

  void resetStatus() {
    emit(state.copyWith(status: CreateTeamStatus.initial, errorMessage: null));
  }

  void searchProgrammers(String query) {
    _searchTimer?.cancel();

    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      emit(
        state.copyWith(
          searchResults: const [],
          searchLoading: false,
          searchError: null,
          lastSearchedQuery: null,
        ),
      );
      return;
    }

    if (trimmed == state.lastSearchedQuery) return;

    emit(state.copyWith(searchLoading: true, searchError: null));

    final token = DateTime.now().millisecondsSinceEpoch.toString();
    _searchSequenceToken = token;

    _searchTimer = Timer(const Duration(milliseconds: 400), () async {
      final result = await searchProgrammersUseCase(trimmed);
      if (_searchSequenceToken != token || isClosed) return;

      result.fold(
        (failure) => emit(
          state.copyWith(
            searchResults: const [],
            searchLoading: false,
            searchError: failure.message,
            lastSearchedQuery: trimmed,
          ),
        ),
        (programmers) {
          final filtered = programmers
              .where((p) => p.fullName.isNotEmpty)
              .toList();
          emit(
            state.copyWith(
              searchResults: filtered,
              searchLoading: false,
              searchError: null,
              lastSearchedQuery: trimmed,
            ),
          );
        },
      );
    });
  }

  void clearSearchResults() {
    _searchTimer?.cancel();
    _searchSequenceToken = null;
    emit(
      state.copyWith(
        searchResults: const [],
        searchLoading: false,
        searchError: null,
        lastSearchedQuery: null,
      ),
    );
  }

  void clearSearchState() {
    _searchTimer?.cancel();
    _searchSequenceToken = null;
  }

  void resetSearchAndInvitations() {
    _searchTimer?.cancel();
    _searchSequenceToken = null;
    emit(
      state.copyWith(
        invitedMembers: const [],
        searchResults: const [],
        searchLoading: false,
        searchError: null,
        lastSearchedQuery: null,
      ),
    );
  }

  Future<void> createTeam({
    required String name,
    required String description,
    required String githubUrl,
  }) async {
    emit(state.copyWith(status: CreateTeamStatus.loading));

    final categoryString = CreateTeamMapper.mapCategoryIndexToString(
      state.selectedCategory,
    );
    final tracks = CreateTeamMapper.mapSelectedRoles(state.selectedRoles);

    final request = CreateTeamParams(
      name: name.trim(),
      description: description.trim(),
      isPublic: state.selectedTeamType == 1,
      githubUrl: githubUrl.trim(),
      categories: [categoryString],
      requiredTracks: tracks,
      invitations: state.invitedMembers,
    );

    final result = await createTeamUseCase(request);

    CreateTeamEntity? entity;
    final failureMessage = result.fold((failure) => failure.message, (right) {
      entity = right;
      return null;
    });

    if (failureMessage != null) {
      emit(
        state.copyWith(
          status: CreateTeamStatus.failure,
          errorMessage: failureMessage,
        ),
      );
      return;
    }

    final entityNonNull = entity!;
    // final teamId = entityNonNull.team.id.toString();
    // final teamName = entityNonNull.team.name;
    emit(
      state.copyWith(
        status: CreateTeamStatus.success,
        entity: entityNonNull,
        invitedMembers: const [],
        searchResults: const [],
        searchLoading: false,
        searchError: null,
      ),
    );

    // final userId = await sl<SecureStorageService>().read(key: AppKeys.userId);
    // if (userId != null && userId.isNotEmpty) {
    //   final chatResult = await createTeamChatRoomUseCase(
    //     CreateTeamChatRoomParams(
    //       teamId: teamId,
    //       teamName: teamName,
    //       creatorId: userId,
    //       memberIds: entityNonNull.invitationsSent,
    //     ),
    //   );
    //   chatResult.fold(
    //     (failure) =>
    //         debugPrint('Chat room creation failed: ${failure.message}'),
    //     (_) => debugPrint('Chat room created for team: $teamId'),
    //   );
    // }
  }
}
