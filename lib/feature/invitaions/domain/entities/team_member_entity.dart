import 'package:equatable/equatable.dart';

class TeamMemberEntity extends Equatable {
  final String name;
  final String? avatarUrl;
  final String track;

  const TeamMemberEntity({
    required this.name,
    this.avatarUrl,
    required this.track,
  });

  @override
  List<Object?> get props => [name, avatarUrl, track];
}
