import 'package:equatable/equatable.dart';

class ReportedUserInfoEntity extends Equatable {
  final int id;
  final String name;
  final String track;
  final String? avatarUrl;

  const ReportedUserInfoEntity({
    required this.id,
    required this.name,
    required this.track,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [id, name, track, avatarUrl];
}
