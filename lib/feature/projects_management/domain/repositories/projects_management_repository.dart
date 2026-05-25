import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/all_projects_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/dashboard/project_dashboard_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/dashboard/submit_project_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/dashboard/team_settings_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/details/completed_project_details_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/details/project_details_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProjectsManagementRepository {
  Future<Either<Failure, AllProjectsEntity>> getAllProjects({int page = 1});
  Future<Either<Failure, AllProjectsEntity>> getCachedProjects();

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
}
