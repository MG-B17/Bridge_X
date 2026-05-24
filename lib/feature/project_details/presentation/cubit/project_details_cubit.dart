import 'package:bridge_x/feature/project_details/domain/entities/project_details_entity.dart';
import 'package:bridge_x/feature/project_details/domain/entities/team_member_entity.dart';
import 'package:bridge_x/feature/project_details/domain/usecases/get_project_details_usecase.dart';
import 'package:bridge_x/feature/project_details/presentation/cubit/project_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectDetailsCubit extends Cubit<ProjectDetailsState> {
  final GetProjectDetailsUseCase getProjectDetailsUseCase;

  ProjectDetailsCubit({required this.getProjectDetailsUseCase})
      : super(const ProjectDetailsInitial());

  int? _projectId;
  String? _status;

  static final ProjectDetailsEntity skeletonPlaceholder = ProjectDetailsEntity(
    id: 0,
    title: 'FinTrack Mobile Pro',
    description: 'A comprehensive financial tracking app built with Flutter and Firebase.',
    status: 'ongoing',
    myTrack: 'general',
    githubLink: 'https://github.com/username/project-name',
    teamMembers: const [
      TeamMemberEntity(id: 1, name: 'Ahmed Ali', roleInTeam: 'member'),
      TeamMemberEntity(id: 2, name: 'Saher Mohamed', roleInTeam: 'member'),
      TeamMemberEntity(id: 3, name: 'Omar Hassan', roleInTeam: 'member'),
    ],
    teamMembersCount: 4,
  );

  ProjectDetailsEntity _currentData() => switch (state) {
        ProjectDetailsLoaded(:final data) => data,
        ProjectDetailsRefreshing(:final data) => data,
        ProjectDetailsLoading(:final placeholderData) =>
          placeholderData ?? skeletonPlaceholder,
        _ => skeletonPlaceholder,
      };

  Future<void> loadProjectDetails({
    required int projectId,
    required String status,
  }) async {
    final sameParams = _projectId == projectId && _status == status;

    if (sameParams &&
        (state is ProjectDetailsLoading || state is ProjectDetailsRefreshing)) {
      return;
    }

    _projectId = projectId;
    _status = status;

    emit(ProjectDetailsLoading(placeholderData: skeletonPlaceholder));

    final result = await getProjectDetailsUseCase(
      GetProjectDetailsParams(projectId: projectId, status: status),
    );

    if (isClosed) return;
    if (_projectId != projectId || _status != status) return;

    result.fold(
      (failure) => emit(ProjectDetailsFailure(failure.message)),
      (data) => emit(ProjectDetailsLoaded(data)),
    );
  }

  Future<void> refreshProjectDetails() async {
    final projectId = _projectId;
    final status = _status;
    if (projectId == null || status == null) return;
    if (state is ProjectDetailsLoading || state is ProjectDetailsRefreshing) return;

    final data = _currentData();
    emit(ProjectDetailsRefreshing(data));

    final result = await getProjectDetailsUseCase(
      GetProjectDetailsParams(projectId: projectId, status: status),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(ProjectDetailsFailure(failure.message)),
      (data) => emit(ProjectDetailsLoaded(data)),
    );
  }

  void retry() {
    final projectId = _projectId;
    final status = _status;
    if (projectId != null && status != null) {
      loadProjectDetails(projectId: projectId, status: status);
    }
  }
}
