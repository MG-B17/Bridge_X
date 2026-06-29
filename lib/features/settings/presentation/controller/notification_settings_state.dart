import 'package:equatable/equatable.dart';

class NotificationSettingsState extends Equatable {
  final bool pushNotificationsEnabled;
  final bool teamUpdatesEnabled;
  final bool newMessagesEnabled;
  final bool taskUpdatesEnabled;
  final bool isLoading;

  const NotificationSettingsState({
    this.pushNotificationsEnabled = true,
    this.teamUpdatesEnabled = true,
    this.newMessagesEnabled = false,
    this.taskUpdatesEnabled = true,
    this.isLoading = false,
  });

  NotificationSettingsState copyWith({
    bool? pushNotificationsEnabled,
    bool? teamUpdatesEnabled,
    bool? newMessagesEnabled,
    bool? taskUpdatesEnabled,
    bool? isLoading,
  }) {
    return NotificationSettingsState(
      pushNotificationsEnabled: pushNotificationsEnabled ?? this.pushNotificationsEnabled,
      teamUpdatesEnabled: teamUpdatesEnabled ?? this.teamUpdatesEnabled,
      newMessagesEnabled: newMessagesEnabled ?? this.newMessagesEnabled,
      taskUpdatesEnabled: taskUpdatesEnabled ?? this.taskUpdatesEnabled,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        pushNotificationsEnabled,
        teamUpdatesEnabled,
        newMessagesEnabled,
        taskUpdatesEnabled,
        isLoading,
      ];
}
