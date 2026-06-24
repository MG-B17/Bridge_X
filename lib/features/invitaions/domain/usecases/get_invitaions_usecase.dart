import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/features/invitaions/domain/entities/invitation_entity.dart';
import 'package:bridge_x/features/invitaions/domain/repositories/invitaions_repository.dart';
import 'package:dartz/dartz.dart';

class GetInvitaionsUseCase {
  final InvitaionsRepository repository;

  GetInvitaionsUseCase({required this.repository});

  Future<Either<Failure, List<InvitationEntity>>> call() async {
    return await repository.getInvitations();
  }
}
