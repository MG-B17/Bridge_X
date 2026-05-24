import 'package:equatable/equatable.dart';

class TeamMemberEntity extends Equatable {
  final int id;
  final String name;
  final String? avatarUrl;
  final String roleInTeam;

  const TeamMemberEntity({
    required this.id,
    required this.name,
    this.avatarUrl,
    required this.roleInTeam,
  });

  @override
  List<Object?> get props => [id, name, avatarUrl, roleInTeam];
}
