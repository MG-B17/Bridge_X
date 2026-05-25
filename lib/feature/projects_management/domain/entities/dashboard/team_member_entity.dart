import 'package:equatable/equatable.dart';

class TeamMemberEntity extends Equatable {
  final int programmerId;
  final String name;
  final String track;
  final String? avatarUrl;

  const TeamMemberEntity({
    required this.programmerId,
    required this.name,
    required this.track,
    required this.avatarUrl,
  });

  @override
  List<Object?> get props => [programmerId, name, track, avatarUrl];
}
