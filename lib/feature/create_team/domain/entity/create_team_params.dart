import 'package:equatable/equatable.dart';

class CreateTeamParams extends Equatable {
  final String name;
  final String description;
  final bool isPublic;
  final String githubUrl;
  final List<String> categories;
  final List<String> requiredTracks;

  const CreateTeamParams({
    required this.name,
    required this.description,
    required this.isPublic,
    required this.githubUrl,
    required this.categories,
    required this.requiredTracks,
  });

  @override
  List<Object?> get props => [
        name,
        description,
        isPublic,
        githubUrl,
        categories,
        requiredTracks,
      ];
}
