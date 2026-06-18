import 'package:bridge_x/feature/invitaions/domain/entities/project_entity.dart';
import 'package:equatable/equatable.dart';

class TeamEntity extends Equatable {
  final String name;
  final int membersCount;
  final ProjectEntity project;
  final String? leaderAvatar;
  final List<String> membersAvatars;

  const TeamEntity({
    required this.name,
    required this.membersCount,
    required this.project,
    this.leaderAvatar,
    this.membersAvatars = const [],
  });

  @override
  List<Object?> get props => [
        name,
        membersCount,
        project,
        leaderAvatar,
        membersAvatars,
      ];
}
