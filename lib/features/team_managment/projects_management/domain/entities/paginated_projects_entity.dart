import 'package:equatable/equatable.dart';
import 'project_item_entity.dart';

class PaginatedProjectsEntity extends Equatable {
  final List<ProjectItemEntity> projects;
  final int currentPage;
  final int lastPage;
  final bool hasMore;

  const PaginatedProjectsEntity({
    required this.projects,
    required this.currentPage,
    required this.lastPage,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [projects, currentPage, lastPage, hasMore];
}
