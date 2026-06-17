import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ResetUnreadCount implements UseCase<void, ResetUnreadCountParams> {
  final ChatRepository repository;

  ResetUnreadCount(this.repository);

  @override
  Future<Either<Failure, void>> call(ResetUnreadCountParams params) async {
    return await repository.resetUnreadCount(params.teamId);
  }
}

class ResetUnreadCountParams extends Equatable {
  final String teamId;

  const ResetUnreadCountParams({required this.teamId});

  @override
  List<Object?> get props => [teamId];
}