import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/features/invitaions/domain/entities/join_request_details_entity.dart';
import 'package:bridge_x/features/invitaions/domain/repositories/invitaions_repository.dart';
import 'package:dartz/dartz.dart';

class GetJoinRequestDetailsUseCase {
  final InvitaionsRepository repository;

  GetJoinRequestDetailsUseCase({required this.repository});

  Future<Either<Failure, JoinRequestDetailsEntity>> call({
    required int joinRequestId,
  }) async {
    return repository.getJoinRequestDetails(joinRequestId: joinRequestId);
  }
}
