import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/entities/join_request_entity.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetJoinRequests implements UseCase<List<JoinRequestEntity>, GetJoinRequestsParams> {
  final ChatRepository repository;

  GetJoinRequests(this.repository);

  @override
  Future<Either<Failure, List<JoinRequestEntity>>> call(GetJoinRequestsParams params) async {
    return await repository.getJoinRequests(params.roomId);
  }
}

class GetJoinRequestsParams extends Equatable {
  final String roomId;

  const GetJoinRequestsParams({required this.roomId});

  @override
  List<Object?> get props => [roomId];
}
