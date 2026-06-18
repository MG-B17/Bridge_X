import 'package:equatable/equatable.dart';

class AcceptedTeamEntity extends Equatable {
  final int id;
  final String name;
  final int currentMembers;
  final int maxMembers;

  const AcceptedTeamEntity({
    required this.id,
    required this.name,
    required this.currentMembers,
    required this.maxMembers,
  });

  @override
  List<Object?> get props => [id, name, currentMembers, maxMembers];
}
