import 'package:equatable/equatable.dart';

class ProgrammerSearchEntity extends Equatable {
  final int id;
  final String? userName;
  final String fullName;
  final String? avatarUrl;
  final String? track;

  const ProgrammerSearchEntity({
    required this.id,
    this.userName,
    required this.fullName,
    this.avatarUrl,
    this.track,
  });

  @override
  List<Object?> get props => [id, userName, fullName, avatarUrl, track];
}
