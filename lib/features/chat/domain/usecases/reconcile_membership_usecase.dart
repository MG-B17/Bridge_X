import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';

class ReconcileMembership implements UseCase<void, NoParams> {
  final ChatRepository repository;

  ReconcileMembership(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.reconcileMembership();
  }
}