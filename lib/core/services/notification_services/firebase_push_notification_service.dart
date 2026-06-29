export 'package:bridge_x/core/services/notification_services/push_notification_service.dart';

import 'dart:io';
import 'package:bridge_x/core/services/logger_service.dart';
import 'package:bridge_x/core/services/notification_services/local_notification_service.dart';
import 'package:bridge_x/core/services/notification_services/push_notification_service.dart';
import 'package:bridge_x/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    LoggerService.info(
      'Background message: ${message.notification?.title ?? message.data['title']}',
      tag: 'PushNotification',
    );
  }
}

class FirebasePushNotificationService implements PushNotificationService {
  FirebasePushNotificationService({required this.localNotificationService});

  final LocalNotificationService localNotificationService;
  late final FirebaseMessaging _fcm;

  String? _fcmToken;

  @override
  String? get fcmToken => _fcmToken;

  @override
  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    _fcm = FirebaseMessaging.instance;

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    if (kDebugMode) {
      LoggerService.info('Firebase initialized', tag: 'PushNotification');
    }

    await _getToken();
    _listenToTokenRefresh();
    _listenToForegroundMessages();
  }

  @override
  Future<void> requestPermission() async {
    final settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (kDebugMode) {
      LoggerService.info(
        'Notification permission: ${settings.authorizationStatus}',
        tag: 'PushNotification',
      );
    }
  }

  @override
  Future<bool> isPermissionGranted() async {
    final settings = await _fcm.getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
  }

  @override
  Future<void> openNotificationSettings() async {
    if (Platform.isAndroid) {
      const channel = MethodChannel('bridge_x/settings');
      await channel.invokeMethod('openNotificationSettings');
    } else if (Platform.isIOS) {
      const channel = MethodChannel('bridge_x/settings');
      await channel.invokeMethod('openNotificationSettings');
    }
  }

  Future<void> _getToken() async {
    try {
      final token = await _fcm.getToken();
      _fcmToken = token;
      if (kDebugMode) {
        LoggerService.info('FCM Token: $token', tag: 'PushNotification');
      }
    } catch (e) {
      if (kDebugMode) {
        LoggerService.error('Failed to get FCM token', exception: e, tag: 'PushNotification');
      }
    }
  }

  void _listenToTokenRefresh() {
    _fcm.onTokenRefresh.listen((newToken) {
      _fcmToken = newToken;
      if (kDebugMode) {
        LoggerService.info('FCM Token refreshed: $newToken', tag: 'PushNotification');
      }
    });
  }

  void _listenToForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        LoggerService.info(
          'Foreground message received: ${message.notification?.title}',
          tag: 'PushNotification',
        );
      }
      final notification = message.notification;
      if (notification != null) {
        localNotificationService.showNotification(
          id: notification.hashCode,
          title: notification.title,
          body: notification.body,
          payload: message.data['route'],
        );
      }
    });
  }

  @override
  Future<void> handleTerminatedMessage() async {
    final message = await _fcm.getInitialMessage();
    if (message != null) {
      if (kDebugMode) {
        LoggerService.info(
          'App opened from terminated state via notification',
          tag: 'PushNotification',
        );
      }
    }
  }

  @override
  Future<String?> refreshToken() async {
    await _getToken();
    return _fcmToken;
  }
}
