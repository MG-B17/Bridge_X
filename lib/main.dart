import 'package:flutter/material.dart';
import 'package:bridgex/core/di/di.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDi();
  runApp(const App());
}
