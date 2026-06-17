import 'package:bridge_x/core/error/error_handler.dart';
import 'package:bridge_x/core/error/error_strings.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/network/network_info.dart';
import 'package:bridge_x/feature/notifications/data/datasources/notifications_remote_data_source.dart';
import 'package:bridge_x/feature/notifications/domain/entities/notification_entity.dart';
import 'package:bridge_x/feature/notifications/domain/entities/unread_count_entity.dart';
import 'package:bridge_x/feature/notifications/domain/repositories/notifications_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  NotificationsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, T>> _safeCall<T>(Future<T> Function() call) async {
    if (!await networkInfo.isConnected) {
      return Left(
        NetworkFailure(message: ErrorStrings.checkYouInternetConnection),
      );
    }
    try {
      return Right(await call());
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message ?? ErrorStrings.serverError),
      );
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications() {
    return _safeCall(() async {
      final response = await remoteDataSource.getNotifications();
      return response.map((notification) => notification.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, void>> markNotificationAsRead({
    required String notificationId,
  }) {
    return _safeCall(
      () => remoteDataSource.markNotificationAsRead(
        notificationId: notificationId,
      ),
    );
  }

  @override
  Future<Either<Failure, void>> markAllNotificationsAsRead() {
    return _safeCall(remoteDataSource.markAllNotificationsAsRead);
  }

  @override
  Future<Either<Failure, UnreadCountEntity>> getUnreadCount() {
    return _safeCall(() async {
      final response = await remoteDataSource.getUnreadCount();
      return response.toEntity();
    });
  }
}
