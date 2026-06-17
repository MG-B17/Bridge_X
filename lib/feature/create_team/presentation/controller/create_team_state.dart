import 'package:bridge_x/core/utils/enum/create_team_status_enum.dart';
import 'package:bridge_x/feature/create_team/domain/entity/create_team_entity.dart';
import 'package:bridge_x/feature/create_team/domain/entity/programmer_search_entity.dart';
import 'package:equatable/equatable.dart';

class CreateTeamState extends Equatable {
  final CreateTeamStatus status;
  final int selectedTeamType;
  final int selectedCategory;
  final List<String> selectedRoles;
  final List<String> invitedMembers;
  final CreateTeamEntity? entity;
  final String? errorMessage;
  final bool showRolesError;
  final List<ProgrammerSearchEntity> searchResults;
  final bool searchLoading;
  final String? searchError;
  final String? lastSearchedQuery;

  const CreateTeamState({
    this.status = CreateTeamStatus.initial,
    this.selectedTeamType = 0,
    this.selectedCategory = 0,
    this.selectedRoles = const ['Frontend', 'UX Designer'],
    this.invitedMembers = const [],
    this.entity,
    this.errorMessage,
    this.showRolesError = false,
    this.searchResults = const [],
    this.searchLoading = false,
    this.searchError,
    this.lastSearchedQuery,
  });

  CreateTeamState copyWith({
    CreateTeamStatus? status,
    int? selectedTeamType,
    int? selectedCategory,
    List<String>? selectedRoles,
    List<String>? invitedMembers,
    CreateTeamEntity? entity,
    String? errorMessage,
    bool? showRolesError,
    List<ProgrammerSearchEntity>? searchResults,
    bool? searchLoading,
    String? searchError,
    String? lastSearchedQuery,
  }) {
    return CreateTeamState(
      status: status ?? this.status,
      selectedTeamType: selectedTeamType ?? this.selectedTeamType,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedRoles: selectedRoles ?? this.selectedRoles,
      invitedMembers: invitedMembers ?? this.invitedMembers,
      entity: entity ?? this.entity,
      errorMessage: errorMessage ?? this.errorMessage,
      showRolesError: showRolesError ?? this.showRolesError,
      searchResults: searchResults ?? this.searchResults,
      searchLoading: searchLoading ?? this.searchLoading,
      searchError: searchError,
      lastSearchedQuery: lastSearchedQuery,
    );
  }

  @override
  List<Object?> get props => [
    status,
    selectedTeamType,
    selectedCategory,
    selectedRoles,
    invitedMembers,
    entity,
    errorMessage,
    showRolesError,
    searchResults,
    searchLoading,
    searchError,
    lastSearchedQuery,
  ];
}
