import 'package:bridge_x/feature/projects_management/domain/entities/paginated_projects_entity.dart';
import 'project_item_model.dart';

class PaginatedProjectsResponseModel {
  final List<ProjectItemModel> projects;
  final int currentPage;
  final int lastPage;
  final String? nextPageUrl;

  const PaginatedProjectsResponseModel({
    required this.projects,
    required this.currentPage,
    required this.lastPage,
    this.nextPageUrl,
  });

  factory PaginatedProjectsResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    final items = (data['data'] as List? ?? [])
        .map((e) => ProjectItemModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return PaginatedProjectsResponseModel(
      projects: items,
      currentPage: data['current_page'] as int? ?? 1,
      lastPage: data['last_page'] as int? ?? 1,
      nextPageUrl: data['next_page_url'] as String?,
    );
  }

  PaginatedProjectsEntity toEntity() => PaginatedProjectsEntity(
        projects: projects.map((m) => m.toEntity()).toList(),
        currentPage: currentPage,
        lastPage: lastPage,
        hasMore: nextPageUrl != null,
      );
}
