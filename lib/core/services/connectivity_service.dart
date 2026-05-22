import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:bridge_x/core/navigation/bridge_x_routes.dart';
import 'package:bridge_x/core/widget/feedback/error_dialog.dart';
import 'package:bridge_x/core/services/logger_service.dart';

class ConnectivityService with WidgetsBindingObserver {
  final InternetConnection _internetConnection;
  StreamSubscription<InternetStatus>? _subscription;
  InternetStatus? _lastStatus;
  bool _isDialogShowing = false;

  ConnectivityService(this._internetConnection);

  void init() {
    WidgetsBinding.instance.addObserver(this);
    LoggerService.info('ConnectivityService initialized', tag: 'ConnectivityService');
    _subscribe();
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _unsubscribe();
    LoggerService.info('ConnectivityService disposed', tag: 'ConnectivityService');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    LoggerService.debug('AppLifecycleState changed in ConnectivityService: $state', tag: 'ConnectivityService');
    if (state == AppLifecycleState.resumed) {
      _subscribe();
    } else if (state == AppLifecycleState.paused ||
               state == AppLifecycleState.inactive ||
               state == AppLifecycleState.detached) {
      _unsubscribe();
    }
  }

  void _subscribe() {
    if (_subscription != null) return;

    LoggerService.debug('Subscribing to connectivity status changes (foreground)', tag: 'ConnectivityService');
    _subscription = _internetConnection.onStatusChange.listen((status) {
      LoggerService.info('Network status: $status (last: $_lastStatus)', tag: 'ConnectivityService');
      
      if (_lastStatus != null) {
        if (status == InternetStatus.disconnected && _lastStatus == InternetStatus.connected) {
          _showNoInternetDialog();
        }
      }
      _lastStatus = status;
    });
  }

  void _unsubscribe() {
    if (_subscription == null) return;

    LoggerService.debug('Cancelling connectivity status changes subscription (background)', tag: 'ConnectivityService');
    _subscription?.cancel();
    _subscription = null;
  }

  void _showNoInternetDialog() {
    final context = rootNavigatorKey.currentContext;
    if (context == null) {
      LoggerService.warning('Cannot show offline dialog: rootNavigatorKey context is null', tag: 'ConnectivityService');
      return;
    }
    if (_isDialogShowing) {
      LoggerService.debug('Offline dialog is already showing, skipping.', tag: 'ConnectivityService');
      return;
    }

    _isDialogShowing = true;
    LoggerService.info('Displaying ErrorDialog for lost network connection', tag: 'ConnectivityService');

    ErrorDialog.show(
      context: context,
      title: 'No Connection',
      message: 'Internet connection lost. Please check your network settings and try again.',
      onAction: () {
        _isDialogShowing = false;
        LoggerService.debug('Offline dialog dismissed', tag: 'ConnectivityService');
      },
    );
  }
}
