import 'package:equatable/equatable.dart';

class ProjectInfoEntity extends Equatable {
  final String title;
  final String category;
  final String description;

  const ProjectInfoEntity({
    required this.title,
    required this.category,
    required this.description,
  });

  @override
  List<Object?> get props => [title, category, description];
}
