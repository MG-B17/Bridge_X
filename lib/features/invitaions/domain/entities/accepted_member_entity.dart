import 'package:equatable/equatable.dart';

class AcceptedMemberEntity extends Equatable {
  final int id;
  final String role;
  final String joinedAt;

  const AcceptedMemberEntity({
    required this.id,
    required this.role,
    required this.joinedAt,
  });

  @override
  List<Object?> get props => [id, role, joinedAt];
}
