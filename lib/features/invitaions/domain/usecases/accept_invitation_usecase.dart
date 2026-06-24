import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/features/invitaions/domain/entities/accepted_invitation_entity.dart';
import 'package:bridge_x/features/invitaions/domain/repositories/invitaions_repository.dart';
import 'package:dartz/dartz.dart';

class AcceptInvitationUseCase {
  final InvitaionsRepository repository;

  AcceptInvitationUseCase({required this.repository});

  Future<Either<Failure, AcceptedInvitationEntity>> call({
    required int invitationId,
  }) async {
    return repository.acceptInvitation(invitationId: invitationId);
  }
}
