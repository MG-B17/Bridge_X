abstract class PushNotificationService {
  Future<void> init();
  String? get fcmToken;
  Future<String?> refreshToken();
  Future<void> handleTerminatedMessage();
  Future<void> requestPermission();
  Future<bool> isPermissionGranted();
  Future<void> openNotificationSettings();
}
