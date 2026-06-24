import 'package:equatable/equatable.dart';

class LeaderEntity extends Equatable {
  final String name;
  final String track;
  final String? avatarUrl;

  const LeaderEntity({
    required this.name,
    required this.track,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [name, track, avatarUrl];
}
