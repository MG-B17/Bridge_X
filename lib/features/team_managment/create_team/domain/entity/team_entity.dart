import 'package:equatable/equatable.dart';

class TeamEntity extends Equatable {
  final int id;
  final String name;
  final int projectId;
  final bool isPublic;
  final String status;
  final String formationType;
  final String? joinCode;
  final String createdAt;
  final String updatedAt;

  const TeamEntity({
    required this.id,
    required this.name,
    required this.projectId,
    required this.isPublic,
    required this.status,
    required this.formationType,
    required this.joinCode,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    projectId,
    isPublic,
    status,
    formationType,
    joinCode,
    createdAt,
    updatedAt,
  ];
}
