import 'package:equatable/equatable.dart';

class CreateTeamRequestModel extends Equatable {
  final String name;
  final String description;
  final bool isPublic;
  final String githubUrl;
  final List<String> categories;
  final List<String> requiredTracks;
  final List<String> invitations;

  const CreateTeamRequestModel({
    required this.name,
    required this.description,
    required this.isPublic,
    required this.githubUrl,
    required this.categories,
    required this.requiredTracks,
    this.invitations = const [],
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'name': name,
      'description': description,
      'is_public': isPublic,
      'github_url': githubUrl,
      'categories': categories,
      'required_tracks': requiredTracks,
    };
    if (!isPublic && invitations.isNotEmpty) {
      json['invitations'] = invitations;
    }
    return json;
  }

  @override
  List<Object?> get props => [
    name,
    description,
    isPublic,
    githubUrl,
    categories,
    requiredTracks,
    invitations,
  ];
}
