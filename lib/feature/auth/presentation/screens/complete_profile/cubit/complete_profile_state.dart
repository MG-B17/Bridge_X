part of 'complete_profile_cubit.dart';

class CompleteProfileState {
  final int selectedTrackIndex;
  final String selectedExperience;
  final bool isLoading;

  const CompleteProfileState({
    this.selectedTrackIndex = -1,
    this.selectedExperience = 'Junior',
    this.isLoading = false,
  });

  CompleteProfileState copyWith({
    int? selectedTrackIndex,
    String? selectedExperience,
    bool? isLoading,
  }) {
    return CompleteProfileState(
      selectedTrackIndex: selectedTrackIndex ?? this.selectedTrackIndex,
      selectedExperience: selectedExperience ?? this.selectedExperience,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
