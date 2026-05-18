class MessageModel {
  final String senderName;
  final String message;
  final String time;
  final String avatar;
  final bool isMe;

  const MessageModel({
    required this.senderName,
    required this.message,
    required this.time,
    required this.avatar,
    required this.isMe,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderName: json['sender_name'] ?? '',
      message: json['message'] ?? '',
      time: json['time'] ?? '',
      avatar: json['avatar'] ?? '',
      isMe: json['is_me'] ?? false,
    );
  }
}