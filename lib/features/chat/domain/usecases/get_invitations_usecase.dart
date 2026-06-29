import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/entities/invitation_entity.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetInvitations implements UseCase<List<InvitationEntity>, GetInvitationsParams> {
  final ChatRepository repository;

  GetInvitations(this.repository);

  @override
  Future<Either<Failure, List<InvitationEntity>>> call(GetInvitationsParams params) async {
    return await repository.getInvitations(params.userId);
  }
}

class GetInvitationsParams extends Equatable {
  final int userId;

  const GetInvitationsParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}
