import 'package:bridge_x/feature/projects_management/domain/entities/all_projects_entity.dart';
import 'ongoing_project_model.dart';
import 'completed_project_model.dart';

class AllProjectsResponseModel {
  final List<OngoingProjectModel> ongoingProjects;
  final List<CompletedProjectModel> completedProjects;
  final int? currentPage;
  final int? totalPages;
  final bool hasMore;

  const AllProjectsResponseModel({
    required this.ongoingProjects,
    required this.completedProjects,
    this.currentPage,
    this.totalPages,
    this.hasMore = false,
  });

  factory AllProjectsResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;

    final ongoingList = data['ongoing_projects'] as List? ?? [];
    final completedList = data['completed_projects'] as List? ?? [];

    final ongoingProjects = ongoingList
        .map((e) => OngoingProjectModel.fromJson(e as Map<String, dynamic>))
        .toList();

    final completedProjects = completedList
        .map((e) => CompletedProjectModel.fromJson(e as Map<String, dynamic>))
        .toList();

    final pagination = data['pagination'] as Map<String, dynamic>?;
    final int? currentPage = pagination != null ? pagination['current_page'] as int? : null;
    final int? totalPages = pagination != null ? pagination['total_pages'] as int? : null;
    final bool hasMore = pagination != null ? (pagination['has_more'] as bool? ?? false) : false;

    return AllProjectsResponseModel(
      ongoingProjects: ongoingProjects,
      completedProjects: completedProjects,
      currentPage: currentPage,
      totalPages: totalPages,
      hasMore: hasMore,
    );
  }

  AllProjectsEntity toEntity() => AllProjectsEntity(
        ongoingProjects: ongoingProjects.map((m) => m.toEntity()).toList(),
        completedProjects: completedProjects.map((m) => m.toEntity()).toList(),
        currentPage: currentPage,
        totalPages: totalPages,
        hasMore: hasMore,
      );

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'ongoing_projects': ongoingProjects.map((m) => m.toJson()).toList(),
        'completed_projects': completedProjects.map((m) => m.toJson()).toList(),
        if (currentPage != null || totalPages != null || hasMore)
          'pagination': {
            'current_page': currentPage,
            'total_pages': totalPages,
            'has_more': hasMore,
          },
      },
    };
  }
}
