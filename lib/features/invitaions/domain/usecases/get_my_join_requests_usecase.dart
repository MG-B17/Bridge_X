import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/features/invitaions/domain/entities/join_request_entity.dart';
import 'package:bridge_x/features/invitaions/domain/repositories/invitaions_repository.dart';
import 'package:dartz/dartz.dart';

class GetMyJoinRequestsUseCase {
  final InvitaionsRepository repository;

  GetMyJoinRequestsUseCase({required this.repository});

  Future<Either<Failure, List<JoinRequestEntity>>> call() async {
    return repository.getJoinRequests();
  }
}
