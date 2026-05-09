import 'package:flutter_bloc/flutter_bloc.dart';

part 'complete_profile_state.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  CompleteProfileCubit() : super(const CompleteProfileState());

  void selectTrack(int index) {
    emit(state.copyWith(selectedTrackIndex: index));
  }

  void selectExperience(String experience) {
    emit(state.copyWith(selectedExperience: experience));
  }

  Future<void> submitProfile() async {
    if (state.selectedTrackIndex == -1) return;
    
    emit(state.copyWith(isLoading: true));
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(isLoading: false));
  }
}
