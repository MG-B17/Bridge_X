import 'package:equatable/equatable.dart';

class JoinRequestTeamEntity extends Equatable {
  final int teamId;
  final String name;

  const JoinRequestTeamEntity({
    required this.teamId,
    required this.name,
  });

  @override
  List<Object?> get props => [teamId, name];
}
