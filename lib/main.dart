import 'package:bridge_x/bridge_x.dart';
import 'package:bridge_x/core/services/logger_service.dart';
import 'package:bridge_x/core/services/notification_services/firebase_push_notification_service.dart';
import 'package:bridge_x/core/services/notification_services/flutter_local_notification_service.dart';
import 'package:bridge_x/core/services/supabase_service.dart';
import 'package:flutter/material.dart';
import 'core/di/di.dart' as di;
import 'dart:ui';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    print("UNCAUGHT ERROR: $error");
    print(stack);
    return true;
  };
  LoggerService.info('🚀 Starting BridgeX Application');

  await SupabaseService().init();
  await di.init();
  await di.sl<LocalNotificationService>().init();
  final pushService = di.sl<PushNotificationService>();
  await pushService.init();
  await pushService.handleTerminatedMessage();
  //di.sl<AppLifecycleService>().init();
  // di.sl<ConnectivityService>().init();

  runApp(const BridgeXApp());
}
