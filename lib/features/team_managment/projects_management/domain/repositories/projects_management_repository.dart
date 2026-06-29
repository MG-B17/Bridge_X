import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/dashboard/project_dashboard_entity.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/dashboard/change_leader_entity.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/dashboard/delete_team_entity.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/dashboard/send_join_request_entity.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/dashboard/submit_project_entity.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/dashboard/team_settings_entity.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/details/completed_project_details_entity.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/details/project_details_entity.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/paginated_projects_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProjectsManagementRepository {
  Future<Either<Failure, PaginatedProjectsEntity>> getProjects({
    int page = 1,
    String? status,
  });

  Future<Either<Failure, ProjectDashboardEntity>> getProjectDashboard(
    int projectId,
  );

  Future<Either<Failure, TeamSettingsEntity>> getTeamSettings(int projectId);

  Future<Either<Failure, SubmitProjectEntity>> submitProjectAsComplete(
    int projectId,
  );

  Future<Either<Failure, ProjectDetailsEntity>> getProjectDetails({
    required int projectId,
    required String status,
  });

  Future<Either<Failure, CompletedProjectDetailsEntity>> getCompletedProjectDetails({
    required int projectId,
  });

  Future<Either<Failure, ChangeLeaderEntity>> changeLeader({
    required int projectId,
    required int userId,
  });

  Future<Either<Failure, DeleteTeamEntity>> deleteTeam(int projectId);

  Future<Either<Failure, SendJoinRequestEntity>> sendJoinRequest({
    required int teamId,
  });
}
