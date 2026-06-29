import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SendInvitation implements UseCase<void, SendInvitationParams> {
  final ChatRepository repository;

  SendInvitation(this.repository);

  @override
  Future<Either<Failure, void>> call(SendInvitationParams params) async {
    return await repository.sendInvitation(params.roomId, params.inviterId, params.inviteeId);
  }
}

class SendInvitationParams extends Equatable {
  final String roomId;
  final int inviterId;
  final int inviteeId;

  const SendInvitationParams({
    required this.roomId,
    required this.inviterId,
    required this.inviteeId,
  });

  @override
  List<Object?> get props => [roomId, inviterId, inviteeId];
}
