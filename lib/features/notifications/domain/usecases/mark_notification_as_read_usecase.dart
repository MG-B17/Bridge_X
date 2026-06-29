import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class MarkNotificationAsReadParams extends Equatable {
  final String notificationId;

  const MarkNotificationAsReadParams({required this.notificationId});

  @override
  List<Object?> get props => [notificationId];
}

class MarkNotificationAsReadUseCase
    implements UseCase<void, MarkNotificationAsReadParams> {
  final NotificationsRepository repository;

  MarkNotificationAsReadUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(MarkNotificationAsReadParams params) {
    return repository.markNotificationAsRead(
      notificationId: params.notificationId,
    );
  }
}
