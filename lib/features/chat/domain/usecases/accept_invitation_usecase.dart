import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AcceptInvitation implements UseCase<void, AcceptInvitationParams> {
  final ChatRepository repository;

  AcceptInvitation(this.repository);

  @override
  Future<Either<Failure, void>> call(AcceptInvitationParams params) async {
    return await repository.acceptInvitation(params.invitationId);
  }
}

class AcceptInvitationParams extends Equatable {
  final String invitationId;

  const AcceptInvitationParams({required this.invitationId});

  @override
  List<Object?> get props => [invitationId];
}
