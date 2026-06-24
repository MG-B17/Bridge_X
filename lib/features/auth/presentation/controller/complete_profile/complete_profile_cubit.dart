import 'package:bridge_x/core/init/app_state.dart';
import 'package:bridge_x/features/auth/utils/auth_enum.dart';
import 'package:bridge_x/features/auth/domain/usecases/complete_profile_usecase.dart';
import 'package:bridge_x/features/auth/presentation/controller/complete_profile/complete_profile_state.dart';
import 'package:bridge_x/features/auth/utils/auth_strings.dart';
import 'package:bridge_x/features/auth/utils/auth_tracks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  CompleteProfileCubit({
    required this.completeProfileUseCase,
    required this.appState,
  }) : super(const CompleteProfileState());

  final CompleteProfileUseCase completeProfileUseCase;
  final AppState appState;

  List<String> get trackLabels => AuthTracks.labels;

  void selectTrack(int index) {
    emit(state.copyWith(selectedTrackIndex: index));
  }

  void selectExperience(String experience) {
    emit(state.copyWith(selectedExperience: experience));
  }

  Future<void> submitProfile() async {
    if (state.selectedTrackIndex == -1) return;
    if (state.status == AuthStatus.loading) return;

    emit(state.copyWith(status: AuthStatus.loading));

    final track = AuthTracks.labels[state.selectedTrackIndex];
    final experience = state.selectedExperience.toLowerCase();

    final result = await completeProfileUseCase(
      track: track,
      experienceLevel: experience,
    );

    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.error, message: failure.message)),
        (_) {
          final current = appState.userData;
          if (current != null) {
            appState.batchUpdate(
              userData: current.copyWith(isProfileComplete: true),
              isProfileComplete: true,
            );
          } else {
            appState.isProfileComplete = true;
          }
          emit(state.copyWith(status: AuthStatus.success, message: AuthStrings.profileCompleted));
        },
    );
  }
}
