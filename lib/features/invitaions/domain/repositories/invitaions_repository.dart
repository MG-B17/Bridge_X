import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/features/invitaions/domain/entities/accept_join_request_entity.dart';
import 'package:bridge_x/features/invitaions/domain/entities/accepted_invitation_entity.dart';
import 'package:bridge_x/features/invitaions/domain/entities/invitation_details_entity.dart';
import 'package:bridge_x/features/invitaions/domain/entities/invitation_entity.dart';
import 'package:bridge_x/features/invitaions/domain/entities/join_request_details_entity.dart';
import 'package:bridge_x/features/invitaions/domain/entities/join_request_entity.dart';
import 'package:dartz/dartz.dart';

class InvitaionsFailure extends Failure {
  const InvitaionsFailure({required super.message, super.statusCode});
}

abstract class InvitaionsRepository {
  Future<Either<Failure, List<InvitationEntity>>> getInvitations();
  Future<Either<Failure, InvitationDetailsEntity>> getInvitationDetails({
    required int invitationId,
  });
  Future<Either<Failure, List<JoinRequestEntity>>> getJoinRequests();
  Future<Either<Failure, JoinRequestDetailsEntity>> getJoinRequestDetails({
    required int joinRequestId,
  });
  Future<Either<Failure, AcceptedInvitationEntity>> acceptInvitation({
    required int invitationId,
  });
  Future<Either<Failure, void>> declineInvitation({required int invitationId});
  Future<Either<Failure, AcceptJoinRequestEntity?>> acceptJoinRequest(String requestId);
  Future<Either<Failure, void>> declineJoinRequest(String requestId);
}
