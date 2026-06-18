import 'package:bridge_x/feature/auth/utils/auth_enum.dart';

class CompleteProfileState {
  final int selectedTrackIndex;
  final String selectedExperience;
  final AuthStatus status;
  final String? message;

  const CompleteProfileState({
    this.selectedTrackIndex = -1,
    this.selectedExperience = 'Junior',
    this.status = AuthStatus.initial,
    this.message,
  });

  CompleteProfileState copyWith({
    int? selectedTrackIndex,
    String? selectedExperience,
    AuthStatus? status,
    bool clearMessage = false,
    String? message,
  }) {
    return CompleteProfileState(
      selectedTrackIndex: selectedTrackIndex ?? this.selectedTrackIndex,
      selectedExperience: selectedExperience ?? this.selectedExperience,
      status: status ?? this.status,
      message: clearMessage ? null : message ?? this.message,
    );
  }
}
