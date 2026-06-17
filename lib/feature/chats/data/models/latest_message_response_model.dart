import 'chat_user_response_model.dart';

class LatestMessageResponseModel {
  final int id;
  final String body;
  final String createdAt;
  final ChatUserResponseModel user;

  LatestMessageResponseModel({
    required this.id,
    required this.body,
    required this.createdAt,
    required this.user,
  });

  factory LatestMessageResponseModel.fromJson(Map<String, dynamic> json) {
    return LatestMessageResponseModel(
      id: json['id'] as int,
      body: json['body'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
      user: ChatUserResponseModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'body': body,
      'created_at': createdAt,
      'user': user.toJson(),
    };
  }
}
