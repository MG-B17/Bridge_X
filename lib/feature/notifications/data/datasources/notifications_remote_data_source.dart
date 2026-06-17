import 'package:bridge_x/core/error/error_strings.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/network/api/api_client.dart';
import 'package:bridge_x/core/network/api/api_endpoint.dart';
import 'package:bridge_x/feature/notifications/data/models/notification_response_model.dart';
import 'package:bridge_x/feature/notifications/data/models/unread_count_response_model.dart';
import 'package:dio/dio.dart';

abstract class NotificationsRemoteDataSource {
  Future<List<NotificationResponseModel>> getNotifications();

  Future<void> markNotificationAsRead({required String notificationId});

  Future<void> markAllNotificationsAsRead();

  Future<UnreadCountResponseModel> getUnreadCount();
}

class NotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSource {
  final ApiClient apiClient;

  NotificationsRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<NotificationResponseModel>> getNotifications() async {
    try {
      final response = await apiClient.get(path: ApiEndpoint.notifications);
      if (response.data == null) {
        throw ServerException('Empty response data received');
      }

      final notifications = _extractNotifications(response.data);
      return notifications
          .whereType<Map>()
          .map(
            (notification) => NotificationResponseModel.fromJson(
              Map<String, dynamic>.from(notification),
            ),
          )
          .toList();
    } catch (e) {
      if (e is DioException || e is ServerException) rethrow;
      throw ServerException(ErrorStrings.serverError);
    }
  }

  @override
  Future<void> markNotificationAsRead({required String notificationId}) async {
    try {
      await apiClient.post(
        path: ApiEndpoint.notificationRead(notificationId: notificationId),
        data: {},
      );
    } catch (e) {
      if (e is DioException || e is ServerException) rethrow;
      throw ServerException(ErrorStrings.serverError);
    }
  }

  @override
  Future<void> markAllNotificationsAsRead() async {
    try {
      await apiClient.post(path: ApiEndpoint.notificationsReadAll, data: {});
    } catch (e) {
      if (e is DioException || e is ServerException) rethrow;
      throw ServerException(ErrorStrings.serverError);
    }
  }

  @override
  Future<UnreadCountResponseModel> getUnreadCount() async {
    try {
      final response = await apiClient.get(
        path: ApiEndpoint.notificationsUnreadCount,
      );
      if (response.data != null) {
        return UnreadCountResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );
      }
      throw ServerException('Empty response data received');
    } catch (e) {
      if (e is DioException || e is ServerException) rethrow;
      throw ServerException(ErrorStrings.serverError);
    }
  }

  List<dynamic> _extractNotifications(dynamic responseData) {
    if (responseData is List) return responseData;
    if (responseData is Map<String, dynamic>) {
      final data = responseData['data'];
      if (data is List) return data;
      if (data is Map<String, dynamic>) {
        final notifications = data['notifications'];
        if (notifications is List) return notifications;
      }
      final notifications = responseData['notifications'];
      if (notifications is List) return notifications;
    }
    return const [];
  }
}
