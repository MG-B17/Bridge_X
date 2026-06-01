import 'package:equatable/equatable.dart';

class EditProfileEntity extends Equatable {
  final int id;
  final String userName;
  final String fullName;
  final String email;
  final String bio;
  final String track;
  final String? avatarUrl;

  const EditProfileEntity({
    required this.id,
    required this.userName,
    required this.fullName,
    required this.email,
    required this.bio,
    required this.track,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [id, userName, fullName, email, bio, track, avatarUrl];
}
