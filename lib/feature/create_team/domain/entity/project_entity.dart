import 'package:equatable/equatable.dart';

class ProjectEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final String categoryName;
  final List<String> categories;
  final List<String> requiredTracks;
  final String githubUrl;
  final String status;
  final int estimatedDurationDays;
  final int userId;
  final String? createdBy;
  final String createdAt;
  final String updatedAt;

  const ProjectEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.categoryName,
    required this.categories,
    required this.requiredTracks,
    required this.githubUrl,
    required this.status,
    required this.estimatedDurationDays,
    required this.userId,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    categoryName,
    categories,
    requiredTracks,
    githubUrl,
    status,
    estimatedDurationDays,
    userId,
    createdBy,
    createdAt,
    updatedAt,
  ];
}
