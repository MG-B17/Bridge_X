import 'package:equatable/equatable.dart';

class JoinRequestProgrammerEntity extends Equatable {
  final int programmerId;
  final String name;
  final String username;
  final String? avatarUrl;
  final String track;
  final String? bio;
  final List<String> skills;
  final double averageStars;

  const JoinRequestProgrammerEntity({
    required this.programmerId,
    required this.name,
    required this.username,
    this.avatarUrl,
    required this.track,
    this.bio,
    required this.skills,
    this.averageStars = 0,
  });

  @override
  List<Object?> get props => [
        programmerId,
        name,
        username,
        avatarUrl,
        track,
        bio,
        skills,
        averageStars,
      ];
}
