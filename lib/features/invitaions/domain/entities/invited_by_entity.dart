import 'package:equatable/equatable.dart';

class InvitedByEntity extends Equatable {
  final String name;
  final String track;
  final String? avatarUrl;

  const InvitedByEntity({
    required this.name,
    required this.track,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [name, track, avatarUrl];
}
