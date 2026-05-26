import 'package:equatable/equatable.dart';

class ViewTaskMemberEntity extends Equatable {
  final int id;
  final String name;
  final String? avatarUrl;
  final String track;
  final String role;

  const ViewTaskMemberEntity({
    required this.id,
    required this.name,
    this.avatarUrl,
    required this.track,
    required this.role,
  });

  @override
  List<Object?> get props => [id, name, avatarUrl, track, role];
}
