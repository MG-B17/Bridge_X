import 'package:equatable/equatable.dart';

class CreateTeamRequestModel extends Equatable {
  final String name;
  final String description;
  final bool isPublic;
  final String githubUrl;
  final List<String> categories;
  final List<String> requiredTracks;

  const CreateTeamRequestModel({
    required this.name,
    required this.description,
    required this.isPublic,
    required this.githubUrl,
    required this.categories,
    required this.requiredTracks,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'is_public': isPublic,
      'github_url': githubUrl,
      'categories': categories,
      'required_tracks': requiredTracks,
    };
  }

  @override
  List<Object?> get props => [name, description, isPublic, githubUrl, categories, requiredTracks];
}
