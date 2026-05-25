import 'package:bridge_x/feature/projects_management/domain/entities/details/feedback_entity.dart';

class FeedbackModel {
  final String text;
  final String author;
  final String badge;
  final double rating;

  const FeedbackModel({
    required this.text,
    required this.author,
    required this.badge,
    required this.rating,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      text: json['text'] as String? ?? '',
      author: json['author'] as String? ?? '',
      badge: json['badge'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }

  FeedbackEntity toEntity() => FeedbackEntity(
        text: text,
        author: author,
        badge: badge,
        rating: rating,
      );
}
