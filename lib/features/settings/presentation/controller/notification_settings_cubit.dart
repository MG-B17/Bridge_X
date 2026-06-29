import 'package:bridge_x/core/services/notification_services/push_notification_service.dart';
import 'package:bridge_x/features/settings/presentation/controller/notification_settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationSettingsCubit extends Cubit<NotificationSettingsState> {
  NotificationSettingsCubit({required this.pushNotificationService})
      : super(const NotificationSettingsState()) {
    _loadPermissionStatus();
  }

  final PushNotificationService pushNotificationService;

  Future<void> _loadPermissionStatus() async {
    emit(state.copyWith(isLoading: true));
    final granted = await pushNotificationService.isPermissionGranted();
    emit(state.copyWith(pushNotificationsEnabled: granted, isLoading: false));
  }

  Future<void> togglePushNotifications(bool enabled) async {
    if (enabled) {
      await pushNotificationService.requestPermission();
      final granted = await pushNotificationService.isPermissionGranted();
      emit(state.copyWith(pushNotificationsEnabled: granted));
    } else {
      await pushNotificationService.openNotificationSettings();
    }
  }

  void setTeamUpdatesEnabled(bool value) {
    emit(state.copyWith(teamUpdatesEnabled: value));
  }

  void setNewMessagesEnabled(bool value) {
    emit(state.copyWith(newMessagesEnabled: value));
  }

  void setTaskUpdatesEnabled(bool value) {
    emit(state.copyWith(taskUpdatesEnabled: value));
  }
}
