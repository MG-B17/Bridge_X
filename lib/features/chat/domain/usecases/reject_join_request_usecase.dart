import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RejectJoinRequest implements UseCase<void, RejectJoinRequestParams> {
  final ChatRepository repository;

  RejectJoinRequest(this.repository);

  @override
  Future<Either<Failure, void>> call(RejectJoinRequestParams params) async {
    return await repository.rejectJoinRequest(params.requestId);
  }
}

class RejectJoinRequestParams extends Equatable {
  final String requestId;

  const RejectJoinRequestParams({required this.requestId});

  @override
  List<Object?> get props => [requestId];
}
