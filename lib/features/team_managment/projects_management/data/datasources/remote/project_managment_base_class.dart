import 'package:bridge_x/features/team_managment/projects_management/data/models/dashboard/change_leader_response_model.dart';
import 'package:bridge_x/features/team_managment/projects_management/data/models/dashboard/delete_team_response_model.dart';
import 'package:bridge_x/features/team_managment/projects_management/data/models/dashboard/project_dashboard_response_model.dart';
import 'package:bridge_x/features/team_managment/projects_management/data/models/dashboard/send_join_request_response_model.dart';
import 'package:bridge_x/features/team_managment/projects_management/data/models/dashboard/submit_project_response_model.dart';
import 'package:bridge_x/features/team_managment/projects_management/data/models/dashboard/team_settings_model.dart';
import 'package:bridge_x/features/team_managment/projects_management/data/models/details/completed_project_details_response_model.dart';
import 'package:bridge_x/features/team_managment/projects_management/data/models/details/project_details_response_model.dart';
import 'package:bridge_x/features/team_managment/projects_management/data/models/paginated_projects_response_model.dart';

abstract class ProjectsManagementRemoteDataSource {
  Future<PaginatedProjectsResponseModel> getProjects({
    int page = 1,
    String? status,
  });

  Future<ProjectDashboardResponseModel> getProjectDashboard(int projectId);

  Future<TeamSettingsModel> getTeamSettings(int projectId);

  Future<SubmitProjectResponseModel> submitProjectAsComplete(int projectId);

  Future<ProjectDetailsResponseModel> getProjectDetails({
    required int projectId,
    required String status,
  });

  Future<CompletedProjectDetailsResponseModel> getCompletedProjectDetails({
    required int projectId,
  });

  Future<ChangeLeaderResponseModel> changeLeader({
    required int projectId,
    required int userId,
  });

  Future<DeleteTeamResponseModel> deleteTeam(int projectId);

  Future<SendJoinRequestResponseModel> sendJoinRequest({
    required int teamId,
  });
}