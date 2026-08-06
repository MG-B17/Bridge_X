import 'package:bridge_x/core/init/app_state.dart';
import 'package:bridge_x/features/team_managment/team_evaluation/domain/entities/evaluation_member_entity.dart';
import 'package:bridge_x/features/team_managment/team_evaluation/domain/usecases/get_team_members_usecase.dart';
import 'package:bridge_x/features/team_managment/team_evaluation/domain/usecases/submit_evaluations_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'team_evaluation_state.dart';

class TeamEvaluationCubit extends Cubit<TeamEvaluationState> {
  final GetTeamMembersUseCase getTeamMembersUseCase;
  final SubmitEvaluationsUseCase submitEvaluationsUseCase;
  final AppState appState;

  String _teamName = '';
  String _projectDescription = '';
  List<EvaluationMemberEntity> _members = const [];
  final Map<int, int> _ratings = {};
  final Map<int, String> _feedback = {};

  TeamEvaluationCubit({
    required this.getTeamMembersUseCase,
    required this.submitEvaluationsUseCase,
    required this.appState,
  }) : super(const TeamEvaluationInitial());

  Future<void> loadMembers(int projectId) async {
    emit(const TeamEvaluationMembersLoading());
    final result = await getTeamMembersUseCase(
      GetTeamMembersParams(projectId: projectId),
    );
    result.fold(
      (failure) => emit(TeamEvaluationMembersFailure(failure.message)),
      (details) {
        _teamName = details.teamName;
        _projectDescription = details.projectDescription;
        _members = _excludeLoggedInUser(details.members);
        _ratings.clear();
        _feedback.clear();
        _emitLoaded();
      },
    );
  }

  void updateRating(int memberId, int rating) {
    if (rating <= 0) {
      _ratings.remove(memberId);
    } else {
      _ratings[memberId] = rating;
    }
    _emitLoaded();
  }

  void updateFeedback(int memberId, String feedback) {
    _feedback[memberId] = feedback;
    _emitLoaded();
  }

  Future<void> submitEvaluations(int projectId) async {
    final evaluations = _buildEvaluations();
    if (evaluations.isEmpty) {
      emit(const TeamEvaluationValidationFailure(
        'Please rate at least one team member before submitting.',
      ));
      return;
    }

    emit(const TeamEvaluationSubmitting());
    final result = await submitEvaluationsUseCase(
      SubmitEvaluationsParams(
        projectId: projectId,
        evaluations: evaluations,
      ),
    );
    result.fold(
      (failure) => emit(TeamEvaluationSubmitFailure(failure.message)),
      (message) => emit(TeamEvaluationSubmitSuccess(message)),
    );
  }

  List<EvaluationMemberEntity> _excludeLoggedInUser(
    List<EvaluationMemberEntity> members,
  ) {
    final currentUserId = int.tryParse(appState.userData?.userId ?? '');
    if (currentUserId == null) return members;
    return members
        .where((member) => member.programmerId != currentUserId)
        .toList();
  }

  List<EvaluationMemberEntity> _selectedMembers() {
    return _members
        .where((member) => (_ratings[member.programmerId] ?? 0) > 0)
        .toList();
  }

  List<Map<String, dynamic>> _buildEvaluations() {
    return _selectedMembers().map((member) {
      final memberId = member.programmerId;
      final evaluation = <String, dynamic>{
        'evaluated_id': memberId,
        'rating': _ratings[memberId] ?? 0,
      };
      final feedback = _feedback[memberId]?.trim() ?? '';
      if (feedback.isNotEmpty) {
        evaluation['feedback'] = feedback;
      }
      return evaluation;
    }).toList();
  }

  void _emitLoaded() {
    emit(TeamEvaluationMembersLoaded(
      teamName: _teamName,
      projectDescription: _projectDescription,
      members: _members,
      selectedMembers: _selectedMembers(),
      ratings: Map.unmodifiable(_ratings),
      feedback: Map.unmodifiable(_feedback),
    ));
  }
}
