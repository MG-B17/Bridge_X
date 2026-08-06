import 'package:bridge_x/features/team_managment/team_evaluation/domain/entities/evaluation_member_entity.dart';
import 'package:equatable/equatable.dart';

sealed class TeamEvaluationState extends Equatable {
  const TeamEvaluationState();

  @override
  List<Object?> get props => [];
}

class TeamEvaluationInitial extends TeamEvaluationState {
  const TeamEvaluationInitial();
}

class TeamEvaluationMembersLoading extends TeamEvaluationState {
  const TeamEvaluationMembersLoading();
}

class TeamEvaluationMembersLoaded extends TeamEvaluationState {
  final String teamName;
  final String projectDescription;
  final List<EvaluationMemberEntity> members;
  final List<EvaluationMemberEntity> selectedMembers;
  final Map<int, int> ratings;
  final Map<int, String> feedback;

  const TeamEvaluationMembersLoaded({
    required this.teamName,
    required this.projectDescription,
    required this.members,
    this.selectedMembers = const [],
    this.ratings = const {},
    this.feedback = const {},
  });

  bool get hasRatedMembers => selectedMembers.isNotEmpty;

  @override
  List<Object?> get props => [
        teamName,
        projectDescription,
        members,
        selectedMembers,
        ratings,
        feedback,
      ];
}

class TeamEvaluationMembersFailure extends TeamEvaluationState {
  final String message;

  const TeamEvaluationMembersFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class TeamEvaluationSubmitting extends TeamEvaluationState {
  const TeamEvaluationSubmitting();
}

class TeamEvaluationSubmitSuccess extends TeamEvaluationState {
  final String message;

  const TeamEvaluationSubmitSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class TeamEvaluationSubmitFailure extends TeamEvaluationState {
  final String message;

  const TeamEvaluationSubmitFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class TeamEvaluationValidationFailure extends TeamEvaluationState {
  final String message;

  const TeamEvaluationValidationFailure(this.message);

  @override
  List<Object?> get props => [message];
}
