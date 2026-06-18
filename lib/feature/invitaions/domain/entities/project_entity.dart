import 'package:equatable/equatable.dart';

class ProjectEntity extends Equatable {
  final String title;
  final String category;
  final String description;
  final String? githubUrl;

  const ProjectEntity({
    required this.title,
    required this.category,
    required this.description,
    this.githubUrl,
  });

  @override
  List<Object?> get props => [title, category, description, githubUrl];
}
