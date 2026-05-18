class ChatModel {
  final String name;
  final String message;
  final String time;
  final String image;
  final int? unreadCount;
  final bool isOnline;

  const ChatModel({
    required this.name,
    required this.message,
    required this.time,
    required this.image,
    this.unreadCount,
    this.isOnline = false,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      name: json['name'] ?? '',
      message: json['message'] ?? '',
      time: json['time'] ?? '',
      image: json['image'] ?? '',
      unreadCount: json['unread_count'],
      isOnline: json['is_online'] ?? false,
    );
  }
}
