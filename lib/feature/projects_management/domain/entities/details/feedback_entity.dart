import 'package:equatable/equatable.dart';

class FeedbackEntity extends Equatable {
  final String text;
  final String author;
  final String badge;
  final double rating;

  const FeedbackEntity({
    required this.text,
    required this.author,
    required this.badge,
    required this.rating,
  });

  @override
  List<Object?> get props => [text, author, badge, rating];
}
