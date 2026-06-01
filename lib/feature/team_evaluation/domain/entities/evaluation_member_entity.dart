import 'package:equatable/equatable.dart';

class EvaluationMemberEntity extends Equatable {
  final int programmerId;
  final String name;
  final String track;
  final String? avatarUrl;

  const EvaluationMemberEntity({
    required this.programmerId,
    required this.name,
    required this.track,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [programmerId, name, track, avatarUrl];
}
