class ChatUserResponseModel {
  final int id;
  final String fullName;

  ChatUserResponseModel({
    required this.id,
    required this.fullName,
  });

  factory ChatUserResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatUserResponseModel(
      id: json['id'] as int,
      fullName: json['full_name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
    };
  }
}
