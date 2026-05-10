import 'package:bridge_x/bridge_x.dart';
import 'package:bridge_x/core/services/logger_service.dart';
import 'package:flutter/material.dart';
import 'core/di/di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  LoggerService.info('🚀 Starting BridgeX Application');

  // Initialize dependencies
  
    await di.init();

  runApp(const BridgeXApp());
}
