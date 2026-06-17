abstract class LocalNotificationService {
  Future<void> init();
  Future<void> showNotification({
    required int id,
    String? title,
    String? body,
    String? payload,
  });
}
