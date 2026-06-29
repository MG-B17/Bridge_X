import 'package:equatable/equatable.dart';

class JoinRequestProjectEntity extends Equatable {
  final int projectId;
  final String name;
  final String? description;

  const JoinRequestProjectEntity({
    required this.projectId,
    required this.name,
    this.description,
  });

  @override
  List<Object?> get props => [projectId, name, description];
}
