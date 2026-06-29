import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AcceptJoinRequest implements UseCase<void, AcceptJoinRequestParams> {
  final ChatRepository repository;

  AcceptJoinRequest(this.repository);

  @override
  Future<Either<Failure, void>> call(AcceptJoinRequestParams params) async {
    return await repository.acceptJoinRequest(params.requestId);
  }
}

class AcceptJoinRequestParams extends Equatable {
  final String requestId;

  const AcceptJoinRequestParams({required this.requestId});

  @override
  List<Object?> get props => [requestId];
}
