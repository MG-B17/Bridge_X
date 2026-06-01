import 'package:bridge_x/feature/team_evaluation/domain/usecases/get_team_members_usecase.dart';
import 'package:bridge_x/feature/team_evaluation/domain/usecases/submit_evaluations_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'team_evaluation_state.dart';

class TeamEvaluationCubit extends Cubit<TeamEvaluationState> {
  final GetTeamMembersUseCase getTeamMembersUseCase;
  final SubmitEvaluationsUseCase submitEvaluationsUseCase;

  TeamEvaluationCubit({
    required this.getTeamMembersUseCase,
    required this.submitEvaluationsUseCase,
  }) : super(const TeamEvaluationInitial());

  Future<void> loadMembers(int teamId) async {
    emit(const TeamEvaluationMembersLoading());
    final result = await getTeamMembersUseCase(
      GetTeamMembersParams(teamId: teamId),
    );
    result.fold(
      (failure) => emit(TeamEvaluationMembersFailure(failure.message)),
      (details) => emit(TeamEvaluationMembersLoaded(
        teamName: details.teamName,
        projectDescription: details.projectDescription,
        members: details.members,
      )),
    );
  }

  Future<void> submitEvaluations(
    int teamId,
    List<Map<String, dynamic>> evaluations,
  ) async {
    emit(const TeamEvaluationSubmitting());
    final result = await submitEvaluationsUseCase(
      SubmitEvaluationsParams(teamId: teamId, evaluations: evaluations),
    );
    result.fold(
      (failure) => emit(TeamEvaluationSubmitFailure(failure.message)),
      (message) => emit(TeamEvaluationSubmitSuccess(message)),
    );
  }
}
