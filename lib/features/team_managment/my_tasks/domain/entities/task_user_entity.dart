import 'package:equatable/equatable.dart';

class TaskUserEntity extends Equatable {
  final int id;
  final String name;
  final String? avatarUrl;

  const TaskUserEntity({
    required this.id,
    required this.name,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [id, name, avatarUrl];
}
