import 'package:equatable/equatable.dart';

class AcceptJoinRequestResponseModel extends Equatable {
  final int teamId;
  final String message;

  const AcceptJoinRequestResponseModel({
    required this.teamId,
    required this.message,
  });

  factory AcceptJoinRequestResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    return AcceptJoinRequestResponseModel(
      teamId: data['team_id'] as int? ?? 0,
      message: json['message'] as String? ?? '',
    );
  }

  @override
  List<Object?> get props => [teamId, message];
}
