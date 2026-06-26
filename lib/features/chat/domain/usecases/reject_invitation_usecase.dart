import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RejectInvitation implements UseCase<void, RejectInvitationParams> {
  final ChatRepository repository;

  RejectInvitation(this.repository);

  @override
  Future<Either<Failure, void>> call(RejectInvitationParams params) async {
    return await repository.rejectInvitation(params.invitationId);
  }
}

class RejectInvitationParams extends Equatable {
  final String invitationId;

  const RejectInvitationParams({required this.invitationId});

  @override
  List<Object?> get props => [invitationId];
}
