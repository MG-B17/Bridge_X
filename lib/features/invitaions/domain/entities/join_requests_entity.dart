import 'package:bridge_x/features/invitaions/domain/entities/join_request_entity.dart';
import 'package:equatable/equatable.dart';

class JoinRequestsEntity extends Equatable {
  final List<JoinRequestEntity> requests;
  final int count;

  const JoinRequestsEntity({
    required this.requests,
    required this.count,
  });

  @override
  List<Object?> get props => [requests, count];
}
