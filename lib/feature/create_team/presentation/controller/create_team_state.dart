import 'package:bridge_x/core/utils/enum/create_team_status_enum.dart';
import 'package:bridge_x/feature/create_team/domain/entity/create_team_entity.dart';
import 'package:equatable/equatable.dart';

class CreateTeamState extends Equatable {
  final CreateTeamStatus status;
  final int selectedTeamType;
  final int selectedCategory;
  final List<String> selectedRoles;
  final CreateTeamEntity? entity;
  final String? errorMessage;
  final bool showRolesError;

  const CreateTeamState({
    this.status = CreateTeamStatus.initial,
    this.selectedTeamType = 0,
    this.selectedCategory = 0,
    this.selectedRoles = const ['Frontend', 'UX Designer'],
    this.entity,
    this.errorMessage,
    this.showRolesError = false,
  });

  CreateTeamState copyWith({
    CreateTeamStatus? status,
    int? selectedTeamType,
    int? selectedCategory,
    List<String>? selectedRoles,
    CreateTeamEntity? entity,
    String? errorMessage,
    bool? showRolesError,
  }) {
    return CreateTeamState(
      status: status ?? this.status,
      selectedTeamType: selectedTeamType ?? this.selectedTeamType,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedRoles: selectedRoles ?? this.selectedRoles,
      entity: entity ?? this.entity,
      errorMessage: errorMessage ?? this.errorMessage,
      showRolesError: showRolesError ?? this.showRolesError,
    );
  }

  @override
  List<Object?> get props => [
    status,
    selectedTeamType,
    selectedCategory,
    selectedRoles,
    entity,
    errorMessage,
    showRolesError,
  ];
}
