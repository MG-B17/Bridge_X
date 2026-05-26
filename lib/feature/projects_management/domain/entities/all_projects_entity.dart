import 'package:bridge_x/feature/projects_management/domain/entities/completed_project_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/ongoing_project_entity.dart';
import 'package:equatable/equatable.dart';

class AllProjectsEntity extends Equatable {
  final List<OngoingProjectEntity> ongoingProjects;
  final List<CompletedProjectEntity> completedProjects;

  final int? currentPage;
  final int? totalPages;
  final bool hasMore;

  const AllProjectsEntity({
    required this.ongoingProjects,
    required this.completedProjects,
    this.currentPage,
    this.totalPages,
    this.hasMore = false,
  });

  bool get isEmpty => ongoingProjects.isEmpty && completedProjects.isEmpty;

  @override
  List<Object?> get props => [ongoingProjects, completedProjects, currentPage, totalPages, hasMore];
}
