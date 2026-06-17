import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/feature/notifications/domain/repositories/notifications_repository.dart';
import 'package:dartz/dartz.dart';

class MarkAllNotificationsAsReadUseCase implements UseCase<void, NoParams> {
  final NotificationsRepository repository;

  MarkAllNotificationsAsReadUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.markAllNotificationsAsRead();
  }
}
