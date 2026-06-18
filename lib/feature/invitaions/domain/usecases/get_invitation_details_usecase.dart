import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/invitaions/domain/entities/invitation_details_entity.dart';
import 'package:bridge_x/feature/invitaions/domain/repositories/invitaions_repository.dart';
import 'package:dartz/dartz.dart';

class GetInvitationDetailsUseCase {
  final InvitaionsRepository repository;

  GetInvitationDetailsUseCase({required this.repository});

  Future<Either<Failure, InvitationDetailsEntity>> call({
    required int invitationId,
  }) async {
    return repository.getInvitationDetails(invitationId: invitationId);
  }
}
