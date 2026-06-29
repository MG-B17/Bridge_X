import 'package:equatable/equatable.dart';

class AcceptJoinRequestEntity extends Equatable {
  final int teamId;

  const AcceptJoinRequestEntity({required this.teamId});

  @override
  List<Object?> get props => [teamId];
}
