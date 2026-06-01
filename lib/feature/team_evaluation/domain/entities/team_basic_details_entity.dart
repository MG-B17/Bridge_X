import 'package:equatable/equatable.dart';
import 'evaluation_member_entity.dart';

class TeamBasicDetailsEntity extends Equatable {
  final String teamName;
  final String projectDescription;
  final List<EvaluationMemberEntity> members;

  const TeamBasicDetailsEntity({
    required this.teamName,
    required this.projectDescription,
    required this.members,
  });

  @override
  List<Object?> get props => [teamName, projectDescription, members];
}
