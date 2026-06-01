import 'evaluation_member_model.dart';

class TeamBasicDetailsResponseModel {
  final String teamName;
  final String projectDescription;
  final List<EvaluationMemberModel> members;

  const TeamBasicDetailsResponseModel({
    required this.teamName,
    required this.projectDescription,
    required this.members,
  });

  factory TeamBasicDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    final membersList = (data['members'] as List? ?? [])
        .map((e) => EvaluationMemberModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return TeamBasicDetailsResponseModel(
      teamName: data['team_name'] as String? ?? '',
      projectDescription: data['project_description'] as String? ?? '',
      members: membersList,
    );
  }
}
