import 'package:equatable/equatable.dart';

class JoinRequestEntity extends Equatable {
  final String id;
  final String userName;
  final String userHandle;
  final String userRole;
  final double userRating;
  final String userAvatar;
  final List<String> expertiseTags;
  final String aboutText;
  final String appliedTimeAgo;
  final bool isNew;

  const JoinRequestEntity({
    required this.id,
    required this.userName,
    required this.userHandle,
    required this.userRole,
    required this.userRating,
    required this.userAvatar,
    required this.expertiseTags,
    required this.aboutText,
    required this.appliedTimeAgo,
    this.isNew = false,
  });

  @override
  List<Object?> get props => [
        id,
        userName,
        userHandle,
        userRole,
        userRating,
        userAvatar,
        expertiseTags,
        aboutText,
        appliedTimeAgo,
        isNew,
      ];
}
