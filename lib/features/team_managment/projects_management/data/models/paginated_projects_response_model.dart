import 'package:bridge_x/features/team_managment/projects_management/domain/entities/paginated_projects_entity.dart';
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
    final rawItems = data['data'] as List? ?? const [];
    final items = rawItems
        .whereType<Map>()
        .map((e) => ProjectItemModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    return PaginatedProjectsResponseModel(
      projects: items,
      currentPage: _readInt(data['current_page'], fallback: 1),
      lastPage: _readInt(data['last_page'], fallback: 1),
      nextPageUrl: data['next_page_url'] as String?,
    );
  }

  static int _readInt(dynamic value, {required int fallback}) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? fallback;
  }

  PaginatedProjectsEntity toEntity() => PaginatedProjectsEntity(
        projects: projects.map((m) => m.toEntity()).toList(),
        currentPage: currentPage,
        lastPage: lastPage,
        hasMore: nextPageUrl != null,
      );
}
