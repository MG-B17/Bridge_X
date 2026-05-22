import 'package:bridge_x/core/services/logger_service.dart';
import 'package:flutter/widgets.dart';

class AppLifecycleService with WidgetsBindingObserver {
  final List<Future<void> Function()> _onShutdownCallbacks = [];

  void registerShutdownCallback(Future<void> Function() callback) {
    _onShutdownCallbacks.add(callback);
  }

  void init() {
    WidgetsBinding.instance.addObserver(this);
    LoggerService.debug('AppLifecycleService initialized', tag: 'AppLifecycle');
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    LoggerService.debug('AppLifecycleService disposed', tag: 'AppLifecycle');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    LoggerService.debug('AppLifecycleState changed: $state', tag: 'AppLifecycle');
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      _executeShutdownCallbacks();
    }
  }

  Future<void> _executeShutdownCallbacks() async {
    LoggerService.debug('Executing shutdown callbacks...', tag: 'AppLifecycle');
    for (final callback in _onShutdownCallbacks) {
      try {
        await callback();
      } catch (e, stack) {
        LoggerService.error('Error executing shutdown callback', exception: e, stackTrace: stack, tag: 'AppLifecycle');
      }
    }
  }
}
