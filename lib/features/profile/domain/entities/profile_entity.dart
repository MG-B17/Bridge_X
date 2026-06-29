import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String name;
  final String track;
  final String? avatarUrl;
  final String level;

  const ProfileEntity({
    required this.name,
    required this.track,
    this.avatarUrl,
    required this.level,
  });

  @override
  List<Object?> get props => [name, track, avatarUrl, level];
}
