import 'package:bridge_x/bridge_x.dart';
import 'package:flutter/material.dart';
import 'core/di/di.dart' as di;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const BridgeXApp());
}


