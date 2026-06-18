import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/invitaions/domain/entities/join_request_entity.dart';
import 'package:bridge_x/feature/invitaions/domain/repositories/invitaions_repository.dart';
import 'package:dartz/dartz.dart';

class GetJoinRequestsUseCase {
  final InvitaionsRepository repository;

  GetJoinRequestsUseCase({required this.repository});

  Future<Either<Failure, List<JoinRequestEntity>>> call() async {
    return await repository.getJoinRequests();
  }
}
