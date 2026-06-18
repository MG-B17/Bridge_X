import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/invitaions/domain/repositories/invitaions_repository.dart';
import 'package:dartz/dartz.dart';

class DeclineInvitationUseCase {
  final InvitaionsRepository repository;

  DeclineInvitationUseCase({required this.repository});

  Future<Either<Failure, void>> call({required int invitationId}) async {
    return repository.declineInvitation(invitationId: invitationId);
  }
}
